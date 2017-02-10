Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

FullCalendar = require 'fullcalendar'

# FIXME
#require '../../node_modules/fullcalendar/dist/fullcalendar.css'
require 'fullcalendar/dist/fullcalendar.css'

HubChannel = Backbone.Radio.channel 'hubby'

#################################
# templates
#################################

tc = require 'teacup'

meeting_calendar = tc.renderable () ->
  tc.div '.listview-header', 'Meetings'
  tc.div '#loading', ->
    tc.h2 ->
      tc.i '.fa.fa-spinner.fa-spin'
      tc.text 'Loading Meetings'
  tc.div '#maincalendar'
#################################

render_calendar_event = (calEvent, element) ->
  calEvent.url = "#hubby/viewmeeting/#{calEvent.id}"
  element.css
    cursor: 'pointer'
    'font-size': '0.9em'

calendar_view_render = (view, element) ->
  HubChannel.request 'maincalendar:set-date'
  
loading_calendar_events = (bool) ->
  loading = $ '#loading'
  header = $ '.fc-toolbar'
  if bool
    loading.show()
    header.hide()
  else
    loading.hide()
    header.show()
  
class MeetingCalendarView extends Backbone.Marionette.View
  template: meeting_calendar
  ui:
    calendar: '#maincalendar'
    
  onDomRefresh: () ->
    date = HubChannel.request 'maincalendar:get-date'
    cal = @ui.calendar
    cal.fullCalendar
      header:
        left: 'prevYear, nextYear'
        center: 'title'
        right: 'prev, next'
      theme: false
      defaultView: 'month'
      eventSources:
        [
          url: '/api/dev/lgr/meetings/hubcal'
        ]
      eventRender: render_calendar_event
      viewRender: calendar_view_render
      loading: loading_calendar_events
      eventClick: (event) ->
        url = event.url
        Backbone.history.navigate url, trigger: true
    # if the current calendar date that has been set,
    # go to that date
    if date != undefined
      cal.fullCalendar('gotoDate', date)
        
      
    
module.exports = MeetingCalendarView
  
