BootStrapAppRouter = require 'agate/src/bootstrap_router'

Controller = require './controller'
require './collections'


MainChannel = Backbone.Radio.channel 'global'
HubChannel = Backbone.Radio.channel 'hubby'

class Router extends BootStrapAppRouter
  appRoutes:
    'hubby': 'mainview'
    'hubby/listmeetings': 'list_meetings'
    'hubby/viewmeeting/:id': 'show_meeting'
    
current_calendar_date = undefined
current_calendar_date = new Date '2016-10-15'
HubChannel.reply 'maincalendar:set-date', () ->
  cal = $ '#maincalendar'
  current_calendar_date = cal.fullCalendar 'getDate'

HubChannel.reply 'maincalendar:get-date', () ->
  current_calendar_date
  
MainChannel.reply 'applet:hubby:route', () ->
  controller = new Controller MainChannel
  router = new Router
    controller: controller

