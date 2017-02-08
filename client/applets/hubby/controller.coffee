Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'agate/src/controllers'
{ SlideDownRegion } = require 'agate/src/regions'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
HubChannel = Backbone.Radio.channel 'hubby'

class AppletLayout extends Backbone.Marionette.View
  template: tc.renderable () ->
    tc.div '#main-content.col-sm-12'
  regions: ->
    region = new SlideDownRegion
      el: '#main-content'
    region.slide_speed = ms '.01s'
    content: region
    
class Controller extends MainController
  layoutClass: AppletLayout
  mainview: ->
    @setup_layout_if_needed()
    console.log "mainview"
    require.ensure [], () =>
      MeetingCalendarView  = require './calendarview'
      view = new MeetingCalendarView
      @_show_content view
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

