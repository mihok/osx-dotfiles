command: """
    network-throughput.widget/lib/network.sh
"""
refreshFrequency: 2000

style: """
    // Size
    height 22px

    // Position this where you want
    top 0
    left 1140px
    z-index 10

    // Statistics text settings
    display flex
    align-items center
    color #fff
    font-family Helvetica Neue

    .container
        display: flex
        flex-direction: row

    .widget-title
        font-size 10px
        font-weight bold
        text-align: widget-align
        text-transform uppercase

    .stat
        margin-left: 16px 
        font-size: 10px
        font-weight: 300
        color: rgba(#fff, .9)
        text-shadow: 0 1px 0px rgba(#000, .7)
        text-align: widget-align

        .icon
            font-family: MesloLGSDZ Nerd Font
            padding: 0 4px

"""

render: -> """
    <div class="container">
        <div class="widget-title">Network</div>
        <div class="stat">
            <i class="icon"></i>
            <span class="down"></span>
        </div>
        <div class="stat">
            <i class="icon"></i>
            <span class="up"></span>
        </div>
    </div>
"""

update: (output, domEl) ->

    usage = (bytes) ->
        kb = bytes / 1024
        usageFormat kb

    usageFormat = (kb) ->
        if kb > 1024
            mb = kb / 1024
            "#{parseFloat(mb.toFixed(1))} MB/s"
        else
            "#{parseFloat(kb.toFixed(2))} KB/s"

    updateStat = (sel, currBytes, totalBytes) ->
        percent = (currBytes / totalBytes * 100).toFixed(1) + "%"
        $(domEl).find(".#{sel}").text usage(currBytes)
        $(domEl).find(".bar-#{sel}").css "width", percent

    args = output.split "^"

    downBytes = (Number) args[0]
    upBytes = (Number) args[1]

    totalBytes = downBytes + upBytes

    updateStat 'down', downBytes, totalBytes
    updateStat 'up', upBytes, totalBytes
