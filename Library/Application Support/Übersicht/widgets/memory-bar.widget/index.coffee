command: "memory_pressure && sysctl -n hw.memsize"

refreshFrequency: 2000

style: """
  // Change bar height
  bar-height = 8px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  top 0
  left 400px
  z-index 10

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background transparent
  padding 0

  .container
    width: 300px
    height: 22px;
    position: relative
    display: flex;
    flex-direction: row;
    justify-content: auto;
    align-items: center;
    font-size: 10px;
    text-align: widget-align

  .widget-title
    text-align: widget-align
    text-transform: uppercase
    font-size: 10px
    font-weight: bold
    color: #fff
    flex-grow: 1

  .bar-container
    width: 200px
    height: 14px
    border: 1px solid rgba(0,0,0,0.5)
    border-radius: 2px
    box-sizing: border-box
    background: transparent
    flex-grow: 4
    padding: 2px

  .bar
    height: bar-height
    float: widget-align
    transition: width .2s ease-in-out
    color: rgba(0,0,0,0.75)
    font-size: 7px
    font-weight: 800
    padding-left: 2px
    box-sizing: border-box

  .bar:first-child
    if widget-align == left
      border-radius: 1px 0 0 1px
    else
      border-radius: 0 1px 1px 0

  .bar:last-child
    if widget-align == right
      border-radius: 1px 0 0 1px
    else
      border-radius: 0 1px 1px 0

  .bar-inactive
    background: rgba(#cdd7b6, 1)

  .bar-active
    background: rgba(#fbb829, 1)

  .bar-wired
    background: rgba(#ff0066, 1)
"""


render: -> """
  <div class="container">
    <div class="widget-title">Memory</div>
    <div class="bar-container">
      <div class="bar bar-wired">
        <span class="wired"></span>
      </div>
      <div class="bar bar-active">
        <span class="active"></span>
      </div>
      <div class="bar bar-inactive">
        <span class="inactive"></span>
      </div>
    </div>
  </div>
"""

update: (output, domEl) ->

  usage = (pages) ->
    mb = (pages * 4096) / 1024 / 1024
    usageFormat mb

  usageFormat = (mb) ->
    if mb > 1024
      gb = mb / 1024
      "#{parseFloat(gb.toFixed(2))}GB"
    else
      "#{parseFloat(mb.toFixed())}MB"

  updateStat = (sel, usedPages, totalBytes) ->
    usedBytes = usedPages * 4096
    percent = (usedBytes / totalBytes * 100).toFixed(1) + "%"
    $(domEl).find(".#{sel}").text usage(usedPages)
    $(domEl).find(".bar-#{sel}").css "width", percent

  lines = output.split "\n"

  freePages = lines[3].split(": ")[1]
  inactivePages = lines[13].split(": ")[1]
  activePages = lines[12].split(": ")[1]
  wiredPages = lines[16].split(": ")[1]

  totalBytes = lines[28]
  $(domEl).find(".total").text usageFormat(totalBytes / 1024 / 1024)

  updateStat 'free', freePages, totalBytes
  updateStat 'active', activePages, totalBytes
  updateStat 'inactive', inactivePages, totalBytes
  updateStat 'wired', wiredPages, totalBytes
