# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Choose where the widget should sit on your screen.
  # verticalPosition    : "bottom"        # top | bottom | center
  # horizontalPosition    : "left"        # left | right | center

  # Choose widget size.
  # widgetVariant: "large"                # large | medium | small

  # Choose color theme.
  widgetTheme: "dark"                   # dark | light

  # Song metadata inside or outside? Applies to large and medium variants only.
  metaPosition: "outside"                # inside | outside

  # Stick the widget in the corner? Set to *true* if you're using it with Sidebar widget, set to *false* if you'd like to give it some breathing room and a drop shadow.
  stickInCorner: false                  # true | false

command: "osascript 'Playbox.widget/lib/Get Current Track.applescript'"
refreshFrequency: '300ms'

style: """

  // Let's do theming first.
  fColor = white
  bgColor = transparent
  bgBrightness = 0%

  // Specify color palette and blur properties.

  fColor1 = rgba(fColor,1.0)
  fColor08 = rgba(fColor,0.8)
  fColor05 = rgba(fColor,0.5)
  fColor02 = rgba(fColor,0.2)
  bgColor1 = rgba(bgColor,1.0)
  bgColor08 = rgba(bgColor,0.7)
  bgColor05 = rgba(bgColor,0.5)
  bgColor02 = rgba(bgColor,0.2)
  blurProperties = blur(10px) brightness(bgBrightness) contrast(100%) saturate(140%)

  // Next, let's sort out positioning.

  mainDimension = 14px


  // Styles.

  *, *:before, *:after
    box-sizing border-box

  // Position widget to fill entire top

  display none
  position absolute
  top 0
  left 0
  right 0
  
  transform-style preserve-3d
  -webkit-transform translate3d(0px, 0px, 0px)
  width auto
  min-width 0
  max-width 100%
  # overflow hidden
  white-space nowrap
  # background-color bgColor02
  font-family "Helvetica Neue"
  border none
  -webkit-backdrop-filter blurProperties
  z-index 10

 
  .wrapper, .album, .artist, .song
    overflow hidden
    text-overflow ellipsis

  .wrapper
    // Position wrapper on the topbar
    position absolute
    left 270px
    height 21px
    width 200px

    // Font styles?
    font-size 8pt
    line-height 11pt
    color fColor1

    // Flex positioning
    display flex
    flex-direction row
    justify-content flex-start
    flex-wrap nowrap
    align-items center
    overflow hidden
    z-index 1

    .art
      width 14px
      height 14px
      margin 0
      background-color fColor05
      background-image url(/Playbox.widget/lib/default.png)
      background-size cover
      border 1px solid black
      z-index 2

    .text
      font-family "Helvetica Neue"
      font-size 7px
      line-height 9px
      margin-left 4px
      width 100%
      max-width 180px
      z-index 3

      .song-information
        min-width 0
        max-width 180px

        .song, .album
          overflow: hidden;
          display: inline-block;
          white-space: nowrap;
          text-overflow: ellipsis;

        .song
          max-width: 58%;
          font-weight 700

        .album 
          max-width: 40%;
          color fColor05

      .heart
        position absolute
        color white
        top 4px
        font-size 16px

  .progress
    width @width
    height 1px
    background #1db954
    position absolute
    top 0
    left 0
    z-index 4

"""

options : options

render: () -> """
  <div class="progress"></div>
  <div class="wrapper">
    <div class="art"><span class="heart">&#9829;</span></div>
    <div class="text">
      <div class="song-information">
        <span class="song"></span>
        <span class="album"></span>
      </div>
      <div class="artist"></div>
    </div>
  </div>
  """

# afterRender: (domEl) ->
  # $.getScript "Playbox.widget/lib/jquery.animate-shadow-min.js"
  # div = $(domEl)

  # meta = div.find('.text')

  # if @options.verticalPosition is 'center'
  #   div.css('top', (screen.height - div.height())/2)
  # if @options.horizontalPosition is 'center'
  #   div.css('left', (screen.width - div.width())/2)

  # if @options.metaPosition is 'inside' and @options.widgetVariant isnt 'small'
  #   meta.delay(3000).fadeOut(500)

  #   div.click(
  #     =>
  #       meta.stop(true,false).fadeIn(250).delay(3000).fadeOut(500)
  #       if @options.stickInCorner is false
  #         div.stop(true,true).animate({zoom: '0.99', boxShadow: '0 0 2px rgba(0,0,0,1.0)'}, 200, 'swing')
  #         div.stop(true,true).animate({zoom: '1.0', boxShadow: '0 20px 40px 0px rgba(0,0,0,0.6)'}, 300, 'swing')
  #         # div.find('.wrapper').stop(true,true).addClass('pushed')
  #         # div.find('.wrapper').stop(true,true).removeClass('pushed')
  #   )

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  if !output
    div.animate({opacity: 0}, 250, 'swing').hide(1)
  else
    values = output.slice(0,-1).split(" @ ")
    div.find('.artist').html(values[0])
    div.find('.song').html(values[1])
    div.find('.album').html(values[2])
    tDuration = values[3]
    tPosition = values[4]
    tArtwork = values[5]
    songChanged = values[6]
    isLoved = values[7]
    currArt = "/" + div.find('.art').css('background-image').split('/').slice(-3).join().replace(/\,/g, '/').slice(0,-1)
    tWidth = div.width()
    tCurrent = (tPosition / tDuration) * tWidth
    div.find('.progress').css width: tCurrent
    # console.log(tArtwork + ", " + currArt)

    div.show(1).animate({opacity: 1}, 250, 'swing')

    if currArt isnt tArtwork and tArtwork isnt 'NA'
      artwork = div.find('.art')
      artwork.css('background-image', 'url('+tArtwork+')')

      # console.log("Changed to: " + tArtwork)

      # Trying to fade the artwork on load, failing so far.
      # if songChanged is 'true'
        # artwork.fadeIn(100)
        # artwork.
        # artwork.fadeIn(500)

      # artwork = div.find('.art')
      # img = new Image
      # img.onload = ->
      #   artwork.css
      #     'background-image': 'url(' + tArtwork + ')'
      #     'background-size': 'contain'
      #   artwork.fadeIn 300
      #   return

      # img.src = tArtwork
      # return
    else if tArtwork is 'NA'
      artwork = div.find('.art')
      artwork.css('background-image', 'url(/Playbox.widget/lib/default.png)')

    if songChanged is 'true' and @options.metaPosition is 'inside' and @options.widgetVariant isnt 'small'
      div.find('.text').fadeIn(250).delay(3000).fadeOut(500)

    if isLoved is 'true'
      div.find('.heart').show()
    else
      div.find('.heart').hide()

  # div.css('max-width', screen.width)

  # Sort out flex-box positioning.
  # div.parent('div').css('order', '9')
  # div.parent('div').css('flex', '0 1 auto')
