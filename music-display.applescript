#!/usr/bin/osascript

# Get a current list of processes to look for our media players in
tell application "System Events"
	set myList to (name of every process)
end tell

set output to "{\"music_display\":{"

################################### HERMES ###################################
if myList contains "Hermes" then
	tell application "Hermes"
		# If Hermes is running, create our output
		set _art to current song's artwork URL
		set _playing to (playback state = playing)
		set _title to title of current song
		set _artist to artist of current song
		set _album to album of current song
		
		set output to output & my JSONify("Hermes", _playing, _art, _title, _artist, _album)
		set output to output & "," # This is annoying, we have to do this because JSON needs the last element to not have a comma
	end tell
end if
################################### END HERMES ###################################

################################### SPOTIFY ###################################
if myList contains "Spotify" then
	tell application "Spotify"
		# This is kind of a hacky way to get the album art in spotify, as the URL we are feeding to curl already returns JSON
		# with all of the information (title, artist, album, art, etc) that we need. However, in an effort to keep outputs
		# from each media player consistant, I will leave it this way for now.
		# Here is an example of what our shell script is searching through:
		#    https://api.spotify.com/v1/tracks/5oUV6yWdDM0R9Q2CizRhIt
		set long_id to id of current track
		set AppleScript's text item delimiters to ":"
		set short_id to long_id's third text item
		set _art to do shell script "curl -X GET 'https://api.spotify.com/v1/tracks/" & short_id & "' | sed -n 12p | awk -F\\\\\\\" '{ print $4}'"
		
		set _playing to (player state = playing)
		set _title to name of current track
		set _artist to artist of current track
		set _album to album of current track
		
		set output to output & my JSONify("Spotify", _playing, _art, _title, _artist, _album)
	end tell
end if
################################### END SPOTIFY ###################################

on JSONify(player, playing, art, title, artist, album)
	return "\"" & player & "\":{\"playing\":" & playing & ",\"art\":\"" & art & "\",\"title\":\"" & title & "\",\"artist\":\"" & artist & "\",\"album\":\"" & album & "\"}"
end JSONify

return output & "}}"