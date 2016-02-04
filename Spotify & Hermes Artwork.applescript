#!/usr/bin/osascript

tell application "System Events"
	set myList to (name of every process)
end tell

set nl to (ASCII character 12)
set esc to (ASCII character 27)
if myList contains "Hermes" then
	tell application "Hermes"
		if playback state is not playing then
			set output to ""
			tell application "GeekTool Helper" to set visible of (first image geeklet whose name is "HermesAlbumArt") to false
		else
			set artUrl to current song's artwork URL
			tell application "GeekTool Helper"
				set albumArt to first image geeklet whose name is "HermesAlbumArt"
				if visible of albumArt is false then
					set visible of albumArt to true
				end if
				set image url of albumArt to artUrl
			end tell
			set output to esc & "[1m" & title of current song & esc & "[0m" & nl
			set output to output & artist of current song & nl
			set output to output & album of current song & nl
		end if
	end tell
else if myList contains "Spotify" then
	tell application "Spotify"
		if player state is not playing then
			set output to ""
			tell application "GeekTool Helper" to set visible of (first image geeklet whose name is "HermesAlbumArt") to false
		else
			set longID to id of current track
			set AppleScript's text item delimiters to ":"
			set shortID to longID's third text item
			set artUrl to do shell script "curl -X GET 'https://api.spotify.com/v1/tracks/" & shortID & "' | sed -n 12p | awk -F\\\\\\\" '{ print $4}'"
			tell application "GeekTool Helper"
				set albumArt to first image geeklet whose name is "HermesAlbumArt"
				if visible of albumArt is false then
					set visible of albumArt to true
				end if
				set image url of albumArt to artUrl
			end tell
			set output to esc & "[1m" & name of current track & esc & "[0m" & nl
			set output to output & artist of current track & nl
			set output to output & album of current track & nl
		end if
	end tell
else
	set output to ""
	tell application "GeekTool Helper" to set visible of (first image geeklet whose name is "HermesAlbumArt") to false
end if

output