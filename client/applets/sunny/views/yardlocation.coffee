_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

{ navigate_to_url
  make_field_input_ui } = require 'agate/src/apputil'

tc = require 'teacup'
{ make_field_input
  make_field_textarea } = require 'agate/src/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'
GpsChannel = Backbone.Radio.channel 'gps'

yard_location_text = (position) ->
  latitude = position.latitude.toPrecision 6
  longitude = position.longitude.toPrecision 6
  "#{latitude}, #{longitude}"  


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

  
    
    
module.exports = BaseYardLocationView
  

