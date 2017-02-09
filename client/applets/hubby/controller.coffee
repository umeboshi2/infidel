Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'agate/src/controllers'
{ SlideDownRegion } = require 'agate/src/regions'
Util = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
HubChannel = Backbone.Radio.channel 'hubby'

class AppletLayout extends Backbone.Marionette.View
  template: tc.renderable () ->
    tc.div '.row', ->
      tc.div  '#main-toolbar.col-sm-12.btn-toolbar'
          
    tc.div '.row', ->
      tc.div '#main-content.col-sm-12'
  regions: ->
    region = new SlideDownRegion
      el: '#main-content'
    region.slide_speed = ms '.01s'
    content: region
    toolbar: '#main-toolbar'
    
class ToolbarView extends Backbone.Marionette.View
  template: tc.renderable () ->
    tc.div '.btn-group', ->
      tc.button '#show-calendar-button.btn.btn-default', 'Calendar'
      tc.button '#list-meetings-button.btn.btn-default', 'List Meetings'
  ui:
    show_cal_btn: '#show-calendar-button'
    list_btn: '#list-meetings-button'
  events:
    'click @ui.show_cal_btn': 'show_calendar'
    'click @ui.list_btn': 'list_meetings'

  show_calendar: ->
    Util.navigate_to_url '#hubby'

  list_meetings: ->
    Util.navigate_to_url '#hubby/listmeetings'
    
      
class Controller extends MainController
  layoutClass: AppletLayout
  setup_layout_if_needed: ->
    super()
    console.log 'layout', @layout
    @layout.showChildView 'toolbar', new ToolbarView
    
  mainview: ->
    @setup_layout_if_needed()
    console.log "mainview"
    require.ensure [], () =>
      MeetingCalendarView  = require './calendarview'
      view = new MeetingCalendarView
      @layout.showChildView 'content', view
    # name the chunk
    , 'hubby-mainview'

  list_meetings: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { MainMeetingModel } = require './collections'
      meetings = HubChannel.request 'meetinglist'
      ListMeetingsView = require './listmeetingsview'
      response = meetings.fetch()
      response.done =>
        if __DEV__ and false
          window.meetings = meetings
          console.log "MEETINGS", meetings
        view = new ListMeetingsView
          collection: meetings
        @layout.showChildView 'content', view
      response.fail =>
        MessageChannel.request 'display-message', 'Failed to load meeting list', 'danger'
    # name the chunk
    , 'hubby-list-meetings-view'

    

  show_meeting: (meeting_id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { MainMeetingModel } = require './collections'
      ShowMeetingView  = require './meetingview'
      meeting = new MainMeetingModel
        id: meeting_id
      response = meeting.fetch()
      response.done =>
        view = new ShowMeetingView
          model: meeting
        @_show_content view
      response.fail =>
        MessageChannel.request 'display-message', 'Failed to load meeting', 'danger'
    # name the chunk
    , 'hubby-meetingview'

    
module.exports = Controller

