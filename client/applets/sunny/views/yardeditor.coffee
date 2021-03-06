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
  make_field_input('name')(model)
  #make_field_input('sunnyclient_id')(model)
  for field in ['description', 'jobdetails']
    make_field_textarea(field)(model)
  tc.input '.btn.btn-default', type:'submit', value:"Submit"
  tc.div '.spinner.fa.fa-spinner.fa-spin'
  
class BaseYardEditor extends BootstrapFormView
  #fieldList: ['name', 'sunnyclient_id']
  fieldList: ['name']
  ui: ->
    uiobject = make_field_input_ui @fieldList
    textareas =
      description: 'textarea[name="description"]'
      jobdetails: 'textarea[name="jobdetails"]'
    _.extend uiobject, textareas
    return uiobject
    
  updateModel: ->
    for field in @fieldList.concat ['description', 'jobdetails']
      console.log 'field', field, @ui[field].val()
      @model.set field, @ui[field].val()
    # update other fields
    #console.log "model sunnyclient_id", @model.get 'sunnyclient_id'

  afterSuccess: ->
    controller = SunnyChannel.request 'main-controller'
    controller.view_yard @model.id
      
  onSuccess: (model) ->
    name = model.get 'name'
    MessageChannel.request 'success', "#{name} saved successfully."
    @afterSuccess model
    
  goViewClient: ->
    client_id = @model.get 'sunnyclient_id'
    navigate_to_url "#sunny/clients/view/#{client_id}"
    

class NewYardView extends BaseYardEditor
  template: YardForm
  createModelOrig: ->
    model = SunnyChannel.request 'new-yard'
    model.set 'sunnyclient_id', @sunnyclient_id
    model
    
  # the model should be assigned in the controller
  createModel: ->
    @model
    
  saveModel: ->
    callbacks =
      success: => @trigger 'save:form:success', @model
      error: => @trigger 'save:form:failure', @model
    yards = SunnyChannel.request 'yard-collection'
    yards.add @model
    super
    
  afterSuccess: ->
    navigate_to_url "#sunny/yards/view/#{@model.id}"
      
    
class EditYardView extends BaseYardEditor
  template: YardForm

  # the model should be assigned in the controller
  createModel: ->
    @model
    
module.exports =
  NewYardView: NewYardView
  EditYardView: EditYardView
  

