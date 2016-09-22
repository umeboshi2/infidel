_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

{ navigate_to_url
  make_field_input_ui } = require 'agate/src/apputil'

tc = require 'teacup'
{ make_field_input
  make_field_textarea } = require 'agate/src/templates/forms'

{ EditYardView
  NewYardView } = require './yardeditor'

YardLocationView = require './yardlocation'
YardRoutineView = require './yardroutine'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'

class NewHeaderView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.text "New Yard"

class YardHeaderView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.text "Yard #{model.name} of "
    tc.a href:"#sunny/clients/view/#{model.sunnyclient_id}", ->
      tc.text "#{model.sunnyclient.fullname}" || 'client'

class YardViewer extends Backbone.Marionette.View
  templateOrig: tc.renderable (model) ->
    tc.div '#yard-header.listview-header'
    tc.div '#location-container.listview-list-entry'
    tc.div '#yard-editor.listview-list-entry'
    tc.div '#yard-routine.listview-list-entry'
    
  template: tc.renderable (model) ->
    tc.div '#yard-header.listview-header'
    tc.div '#yard-routine.listview-list-entry'
    tc.div '#location-container.listview-list-entry'
    tc.div '#yard-editor.listview-list-entry'
    
  regions:
    header: '#yard-header'
    location: '#location-container'
    editor: '#yard-editor'
    routine: '#yard-routine'
    
    
  _show_viewclass: (region, ViewClass) ->
    view = new ViewClass
      model: @model
    @showChildView region, view
    
  onRender: ->
    if @model.has 'name'
      headerClass = YardHeaderView
      editorClass = EditYardView
    else
      headerClass = NewHeaderView
      editorClass = NewYardView
    @_show_viewclass 'header', headerClass
    @_show_viewclass 'editor', editorClass
    @_show_viewclass 'location', YardLocationView
    @_show_viewclass 'routine', YardRoutineView
    
    
    
module.exports = YardViewer
  

