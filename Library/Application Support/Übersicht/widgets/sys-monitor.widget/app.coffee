command: "ps aux | awk '{cpu+=$3} END {print cpu}'"

refreshFrequency: 1000

render: (output) -> """
  <link rel="stylesheet" href="sys-monitor.widget/lib/epoch/epoch.min.css">
  <div class="container">
    <div class="widget-title">CPU</div>
    <div id="chart" class="chart-container epoch"></div>
  </div>
"""

chart: null

sysctl:
  logicalcpu: 0
  memsize: 0

getTime: -> new Date().getTime() / 1000

afterRender: (domEl) ->
  $.getScript "sys-monitor.widget/lib/d3/d3.min.js.lib", =>
    $.getScript "sys-monitor.widget/lib/epoch/epoch.min.js.lib", =>
      @chart = $(domEl).find('#chart').epoch
        type: 'time.area'
        fps: 20
        queueSize: 120
        height: 36
        width: 100
        data: [
          {label: 'CPU', values: [{time: @getTime(), y: 0}]}
        ]

  @run "sysctl -n machdep.cpu.brand_string; sysctl -n hw.logicalcpu; sysctl -n hw.memsize", (err, stdout) =>
    [cpubrand, @sysctl.logicalcpu, @sysctl.memsize] = stdout.split("\n")

update: (output, domEl) ->
  if @sysctl.logicalcpu > 0 and @sysctl.memsize > 0
    cpu = output.split("\n")[0]
    cpu_per = cpu / @sysctl.logicalcpu

    @chart.push([
      {time: @getTime(), y: cpu_per}
    ]) if @chart?

style: """
  top: 0
  left: 720px
  height: 22px

  svg
    display: none

  canvas
    margin-left: -3px
    margin-top: -1px

  .container
    width: 130px
    height: 22px
    display: flex
    flex-direction: row
    align-items: center
    
    .widget-title
      text-transform: uppercase
      font-family: "Helvetica Neue"
      font-weight: bold
      font-size: 10px
      flex-grow 1
      color: #fff

    .chart-container
      height: 14px
      width: 39px
      border: 1px solid rgba(0,0,0,0.5)
      border-radius: 3px
      box-sizing: border-box
      padding: 1px
      flex-grow 4

"""
