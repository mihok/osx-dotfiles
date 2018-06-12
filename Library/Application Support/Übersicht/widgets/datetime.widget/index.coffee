command: "date +'%A %B %d, %Y %H:%M:%S'"

refreshFrequency: 999

style: """
  // Position this where you want
  top 0
  right 100px

  display flex
  align-items center

  // Topbar height
  height 22px

  color rgba(#fff, .7)
  font-family Helvetica Neue
  font-size 10px
  // text-transform uppercase

  .icon
    font-family MesloLGSDZ Nerd Font
    font-style normal
    font-size 11px
    color #fff
    padding-right 8px

"""


render: -> """
  <div class="date">
    <i class="icon"></i>
    <span class="time"></span>
  </div>
"""

update: (output, domEl) ->
  $(domEl).find('.time').text(output)
