_ = require 'underscore'
Backbone = require 'backbone'

BootstrapFormView = require 'agate/src/bootstrap_formview'

{ navigate_to_url
  make_field_input_ui } = require 'agate/src/apputil'

tc = require 'teacup'
{ make_field_input
  make_field_textarea } = require 'agate/src/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'

YardForm = tc.renderable (model) ->
  tc.div '.listview-header', 'Yard'
  tc.a href:"#sunny/clients/view/#{model.sunnyclient_id}", 'View Client'
  make_field_input('name')(model)
  tc.div "#yard-location"
  for field in ['description', 'jobdetails']
    make_field_textarea(field)(model)
  tc.input '.btn.btn-default', type:'submit', value:"Submit"
  tc.div '.spinner.fa.fa-spinner.fa-spin'
  
class BaseYardEditor extends BootstrapFormView
  fieldList: ['name']
  ui: ->
    uiobject = make_field_input_ui @fieldList
    textareas =
      description: 'textarea[name="description"]'
      jobdetails: 'textarea[name="jobdetails"]'
      yardLocation: '#yard-location'
    _.extend uiobject, textareas
    return uiobject

  onDomRefresh: (event) ->
    console.log 'onDomRefresh called on BaseYardEditor'
    @get_location()
    

  locationSuccess: (position) =>
    position = position.coords
    console.log 'locationSuccess', position
    @currentPosition = position
    @ui.yardLocation.text "#{position.latitude}, #{position.longitude}"
    
  get_location: ->
    console.log "getting location..."
    navigator.geolocation.getCurrentPosition @locationSuccess, @locationError
    

    

  updateModel: ->
    for field in @fieldList.concat ['description', 'jobdetails']
      console.log 'field', field, @ui[field].val()
      @model.set field, @ui[field].val()
    # update other fields
      console.log "model sunnyclient_id", @model.get 'sunnyclient_id'
      
  onSuccess: (model) ->
    name = model.get 'name'
    MessageChannel.request 'display-message', "#{name} saved successfully.", "success"
    navigate_to_url '#sunny'
    

class NewYardView extends BaseYardEditor
  template: YardForm
  createModel: ->
    model = SunnyChannel.request 'new-yard'
    model.set 'sunnyclient_id', @sunnyclient_id
    model
    
  saveModel: ->
    callbacks =
      success: => @trigger 'save:form:success', @model
      error: => @trigger 'save:form:failure', @model
    yards = SunnyChannel.request 'yard-collection'
    yards.add @model
    super
    
class EditYardView extends BaseYardEditor
  template: YardForm

  # the model should be assigned in the controller
  createModel: ->
    @model
    
module.exports =
  NewYardView: NewYardView
  EditYardView: EditYardView
  

