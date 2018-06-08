# Lovingly crafted by Rohan Likhite [rohanlikhite.com]
command: "finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ // '"


#Refresh time (default: 1/2 minute 30000)
refreshFrequency: 999


#Body Style
style: """

  color: #fff
  font-family: Helvetica Neue, Arial
  top: 0
  left: 0
  bottom: 0
  right: 0

  .container
   display: flex
   flex-direction: column;
   justify-content: center
   align-items: center
   height:100%
   width:100%
   font-weight: lighter
   font-smoothing: antialiased
   text-shadow:0px 0px 20px rgba(0,0,0,0.3);

  .time
   font-size: 10em
   color:#fff
   font-weight:700
   text-align:center
   width: 100%
   display: flex
   justify-content: center
   align-items: baseline
   margin-top: -128px

  .half
   font-size:0.15em

  .text
   font-size: 4em
   color:#fff
   font-weight:700
   width: 100%
   text-align: center
   margin-top: -20px

  .min
   margin-left: 10px
   margin-right: 10px
 
  .second
   margin-left: 10px
  
  .name
   margin-left: -20px 
"""

#Render function
render: -> """
  <div class="container">
  <div class="time">
  <span class="hour"></span>:
  <span class="min"></span>:
  <span class="second"></span>
  <span class="half"></span>
  </div>
  <div class="text">
  <span class="salutation"></span>
  <span class="name">Mihok</span>
  </div>
  </div>

"""

  #Update function
update: (output, domEl) ->

  #Options: (true/false)
  showAmPm = true;
  showName = true;
  fourTwenty = false; #Smoke Responsibly
  militaryTime = false; #Military Time = 24 hour time

  #Time Segmends for the day
  segments = ["morning", "afternoon", "evening", "night"]

  #Grab the name of the current user.
  #If you would like to edit this, replace "output.split(' ')" with your name
  name = "mihok"


  #Creating a new Date object
  date = new Date()
  
  hour = date.getHours()
  minutes = date.getMinutes()
  seconds = date.getSeconds()

  #Quick and dirty fix for single digit minutes
  minutes = "0"+ minutes if minutes < 10
  seconds = "0"+ seconds if seconds < 10

  #timeSegment logic
  timeSegment = segments[0] if 4 < hour <= 11
  timeSegment = segments[1] if 11 < hour <= 17
  timeSegment = segments[2] if 17 < hour <= 24
  timeSegment = segments[3] if  hour <= 4

  #AM/PM String logic
  if hour < 12
    half = "AM"
  else
    half = "PM"

  #0 Hour fix
  hour= 12 if hour == 0;

  #420 Hour
  if hour == 16 && minutes == 20
    blazeIt = true
  else
    blazeIt = false

  #24 - 12 Hour conversion
  hour = hour%12 if hour > 12 && !militaryTime

  #DOM manipulation
  if fourTwenty && blazeIt 
    $(domEl).find('.salutation').text("Blaze It")
  else
    $(domEl).find('.salutation').text("Good #{timeSegment}") 
  $(domEl).find('.name').text(" , #{name}.") if showName
  $(domEl).find('.hour').text("#{hour}")
  $(domEl).find('.min').text("#{minutes}")
  $(domEl).find('.second').text("#{seconds}")
  $(domEl).find('.half').text("#{half}") if showAmPm && !militaryTime
