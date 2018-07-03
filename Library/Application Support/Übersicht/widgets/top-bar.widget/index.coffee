command: "system_profiler SPSoftwareDataType"

refreshFrequency: 2000

style: """
  // Align contents left or right
  widget-align = left

  // Position this where you want
  top 0px
  left 0px
  right 0px

  // Topbar height
  height 22px

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .3)
  padding 0 0 0 8px

  .container
   width: 100%
   text-align: widget-align
   position: relative
   clear: both

   .name, .version, .uptime
    font-size: 10px
    text-align: widget-align
    color: #ccc
   .name
    text-transform: uppercase
    font-weight: bold
    color: #fff

   .version
    font-weight: 400
    margin-left: 8px

   .uptime
    font-weight: 400
    color: #fff
    margin-left: -4px

   .uptime:after, .uptime:before
    content: "/"
    color: #444
    padding: 0 8px

"""


render: -> """
  <div class="container">
    <span class="name"></span>
    <span class="version"></span>
    <span class="uptime"></span>
  </div>
"""

update: (output, domEl) ->
  outputLines = output.split "\n"
  # outputUptime = outputLines[12].split(": ")
  outputUptime = outputLines[12].split(": ")[1]
  outputUptimeArray = outputUptime.split(":")


  if outputUptimeArray.length > 1
    computerUptimeHours = outputUptimeArray[0]
    computerUptimeMinutes = outputUptimeArray[1]
  else
    computerUptimeHours = 0
    computerUptimeMinutes = Number.parseInt(outputUptimeArray[0])

  computerName = outputLines[8].split(": ")[1]
  computerVersion = outputLines[4].split(": ")[1]

  $(domEl).find('.name').text("#{computerName}")
  $(domEl).find('.version').text("#{computerVersion}")
  $(domEl).find('.uptime').text("#{computerUptimeHours}h #{computerUptimeMinutes}m")
