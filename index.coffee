command: "osascript 'music-display.widget/music-display.applescript'"

refreshFrequency: 5000

render: (output) ->
    console.log output
    output = JSON.parse(output)
    html = '';
    for i of output.music_display
        html += "<div class=\"container\" style=\"display:flex; flex-direction:row;\">"
        html +=     "<div class=\"art-container\">"
        if output.music_display[i].art != ""
            html +=         "<div class=\"art\" id=\"art_one\" style=\"background-image:url('#{output.music_display[i].art}');\"></div>"
        html +=     "</div>"
        html +=     "<div class=\"song-info\" style=\"display:flex; flex-direction:column; justify-content:flex-end;\">"
        html +=         "<div id=\"song-title\">#{output.music_display[i].title}</div>"
        html +=         "<div id=\"song-artist\">#{output.music_display[i].artist}</div>"
        html +=         "<div id=\"song-album\">#{output.music_display[i].album}</div>"
        html +=     "</div>"
        html += "</div>"
    return html

style: """
    size = 275px

    left: 0px
    bottom: 0px
    color: white
    font-family: Helvetica Neue
    font-size: 30px

    .song-info
        margin: 0px 0px 5px 10px

    #song-title
        font-weight: 900

    #song-artist, #song-album
        font-weight: 100

    .art-container > .art
        width: size
        height: size
        background-size: cover
        background-position: center

    .art-container
        height: size

    .container
        padding: 0px

"""
