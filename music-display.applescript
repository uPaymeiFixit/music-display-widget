#!/usr/bin/osascript

# Get a current list of processes to look for our media players in
tell application "System Events"
	set processes_list to (name of every process)
end tell

# We will set this to true if we find a service running, so that we can remove the comma from the last one
set found to false

set output to "{\"music_display\":{"

################################### HERMES ###################################
if processes_list contains "Hermes" then
	tell application "Hermes"
		# If Hermes is running, create our output
		set _art to current song's artwork URL
		set _playing to (playback state = playing)
		set _title to title of current song
		set _artist to artist of current song
		set _album to album of current song
		
		set output to output & my JSONify("Hermes", _playing, _art, _title, _artist, _album)
		set found to true
	end tell
end if
################################### END HERMES ###################################

################################### SPOTIFY ###################################
if processes_list contains "Spotify" then
	tell application "Spotify"
		# This is kind of a hacky way to get the album art in spotify, as the URL we are feeding to curl already returns JSON
		# with all of the information (title, artist, album, art, etc) that we need. However, in an effort to keep outputs
		# from each media player consistant, I will leave it this way for now.
		# Here is an example of what our shell script is searching through:
		#    https://api.spotify.com/v1/tracks/5oUV6yWdDM0R9Q2CizRhIt
		# Real Shell call 
		#   curl -s -X GET 'https://api.spotify.com/v1/tracks/46SNlNPyoPOF19hGF4dbBD' | grep -o 'https:\/\/i.scdn.co\/image\/.\{40\}' | head -1
		set long_id to id of current track
		set AppleScript's text item delimiters to ":"
		set short_id to long_id's third text item
		set _art to do shell script "curl -s -X GET 'https://api.spotify.com/v1/tracks/" & short_id & "' | grep -o 'https:\\/\\/i.scdn.co\\/image\\/.\\{40\\}' | head -1"
		
		set _playing to (player state = playing)
		set _title to name of current track
		set _artist to artist of current track
		set _album to album of current track
		
		set output to output & my JSONify("Spotify", _playing, _art, _title, _artist, _album)
		set found to true
	end tell
end if
################################### END SPOTIFY ###################################

on JSONify(player, playing, art, title, artist, album)
	return "\"" & player & "\":{\"playing\":" & playing & ",\"art\":\"" & art & "\",\"title\":\"" & title & "\",\"artist\":\"" & artist & "\",\"album\":\"" & album & "\"},"
end JSONify

# If one of the players is running, remove the last comma, because JSON freaks out otherwise.
if found is true then
	set output to text 1 thru -2 of output
end if

return output & "}}"
