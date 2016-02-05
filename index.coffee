command: "osascript 'music-display.widget/music-display.applescript'"

refreshFrequency: 500000

render: (output) ->
    console.log output
    output = JSON.parse(output)
    console.log output.music_display
    html = '';
    for i of output.music_display
        if output.music_display[i].art == ""
            output.music_display[i].art = "music-display.widget/images/default.png"
        html += "<div class=\"container\" style=\"display:flex; flex-direction:row;\">"
        html +=     "<div class=\"art-container\">"
        html +=         "<div class=\"art\" id=\"art_one\" style=\"background-image:url('#{output.music_display[i].art}');\"></div>"
        # html +=         "<img id=\"art_two\" src=\"#{output.music_display[i].art}\" />"
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


    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-Thin.ttf') format('truetype')
        font-weight: 100
        font-style: normal

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-ThinItalic.ttf') format('truetype')
        font-weight: 100
        font-style: italic

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-Light.ttf') format('truetype')
        font-weight: 300
        font-style: normal

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-LightItalic.ttf') format('truetype')
        font-weight: 300
        font-style: italic

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-Regular.ttf') format('truetype')
        font-weight: 400
        font-style: normal

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-RegularItalic.ttf') format('truetype')
        font-weight: 400
        font-style: italic

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-Medium.ttf') format('truetype')
        font-weight: 500
        font-style: normal

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-MediumItalic.ttf') format('truetype')
        font-weight: 500
        font-style: italic

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-Bold.ttf') format('truetype')
        font-weight: 700
        font-style: normal

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-BoldItalic.ttf') format('truetype')
        font-weight: 700
        font-style: italic

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-Black.ttf') format('truetype')
        font-weight: 900
        font-style: normal

    @font-face
        font-family: Roboto
        src: url('music-display.widget/fonts/Roboto-BlackItalic.ttf') format('truetype')
        font-weight: 900
        font-style: italic

"""
