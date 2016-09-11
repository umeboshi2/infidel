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

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'
GpsChannel = Backbone.Radio.channel 'gps'

yard_location_text = (position) ->
  latitude = position.latitude.toPrecision 6
  longitude = position.longitude.toPrecision 6
  "#{latitude}, #{longitude}"  

client_link = tc.renderable (model) ->
  tc.a href:"#sunny/clients/view/#{model.sunnyclient_id}", 'View Client'



class NewHeaderView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.text "New Yard"

class YardHeaderView extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.text "Yard #{model.name} of "
    tc.a href:"#sunny/clients/view/#{model.sunnyclient_id}", ->
      tc.text "#{model.sunnyclient.fullname}" || 'client'

class BaseYardLocationView extends Backbone.Marionette.View
  template:  tc.renderable (model) ->
    tc.span "Location:"
    if model?.geoposition
      ytext = yard_location_text model.geoposition
    else
      ytext = 'Not Set'
    tc.div '#yard-location-button.btn.btn-default.pull-right', ''
    tc.div "#yard-location", ytext

  ui: ->
    yardLocation: '#yard-location'
    yardButton: '#yard-location-button'
  events: ->
    'click @ui.yardButton': 'yard_button'

  currentPosition: null
  
  yard_button: (event) ->
    if @currentPosition is null
      @get_location()
    else
      @saveCurrentPosition()
        
  setGettingLocationHtml: (source) ->
    @ui.yardLocation.html tc.render ->
      tc.span "getting location from #{source}......"
      tc.i '.fa.fa-spinner.fa-spin'


  addNewYard: ->
    gp = GpsChannel.request 'new-position'
    gp.set @currentPosition
    response = gp.save()
    response.done (data, status, xhr) =>
      console.log "new position added"
      console.log 'data', data
      @model.set 'location_id', data.id
      name = yard_location_text data
      @model.set 'name', name
      mresponse = @model.save()
      mresponse.done (data, status, xhr) =>
        msg = "Yard #{data.name} added successfully!"
        MessageChannel.request 'success', msg
        navigate_to_url "#sunny/yards/view/#{data.id}"
        

  addNewPositionToYard: ->
    null
    
  updateYardLocation: ->
    location_id = @model.get('location_id')
    new_position = false
    success_msg = "New Yard Position Saved"
    if location_id is null
      new_position = true
      gp = GpsChannel.request 'new-position'
    else
      gp = GpsChannel.request 'get-position', location_id
    gp.set @currentPosition
    MessageChannel.request 'info', 'Adding new position to yard', false, 2000
    response = gp.save()
    response.done (data, status, xhr) =>
      if new_position
        @model.set 'location_id', data.id
        mresponse = @model.save()
        mresponse.done =>
          MessageChannel.request 'success', success_msg
      else
        MessageChannel.request 'success', success_msg
    
  saveCurrentPosition: ->
    if @model.has 'id'
      MessageChannel.request 'info', 'Update Yard Position'
      @updateYardLocation()
    else
      MessageChannel.request 'info', 'Add new Yard'
      @addNewYard()
      
  saveCurrentPositionOrig: ->
    @model.set @currentPosition
    navigate_to_viewyard = false
    if not @model.has 'id'
      navigate_to_viewyard = true
    if not @model.has 'name'
      name = yard_location_text @model.attributes
      @model.set 'name', name
    response = @model.save()
    response.done (data, status, xhr) =>
      MessageChannel.request 'success', 'Position saved successfully!'
      @ui.yardButton.text 'Get Location'
      @currentPosition = null
      if navigate_to_viewyard
        navigate_to_url "#sunny/yards/view/#{@model.id}"

  # need double arrow to use as callback
  locationSuccess: (position) =>
    position = position.coords
    @currentPosition = position
    @ui.yardLocation.text yard_location_text position
    if @model.attributes?.geoposition
      @ui.yardButton.text 'Save New Position'
    else
      @ui.yardButton.text 'Set Position'
    @ui.yardButton.show()

  locationError: () =>
    MessageChannel.request 'warning', 'Unable to get current location.'
    
    
  get_location: ->
    @ui.yardButton.hide()
    console.log "getting location..."
    @setGettingLocationHtml 'browser'
    navigator.geolocation.getCurrentPosition @locationSuccess, @locationError

  onDomRefresh: ->
    console.log "onDomRefresh called"
    @setGettingLocationHtml 'database'
    geoposition = @model.get 'geoposition'
    if geoposition
      @ui.yardLocation.text yard_location_text geoposition
      @ui.yardButton.text 'Update Location'
      return
    else if not geoposition?.latitude and @model.id
      MessageChannel.request 'warning', "There is no gps location for this yard!"
    @ui.yardLocation.text 'Unset'
    @ui.yardButton.text 'Get Location'

  
class YardViewer extends Backbone.Marionette.View
  template: tc.renderable (model) ->
    tc.div '#yard-header.listview-header'
    tc.div '#location-container.listview-list-entry'
    tc.div '#yard-editor.listview-list-entry'
  regions:
    header: '#yard-header'
    location: '#location-container'
    editor: '#yard-editor'
    
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
    @_show_viewclass 'location', BaseYardLocationView

    
    
module.exports = YardViewer
  

