_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
FullCalendar = require 'fullcalendar'
require 'fullcalendar/dist/fullcalendar.css'

BootstrapFormView = require 'agate/src/bootstrap_formview'
{ navigate_to_url
  make_field_input_ui } = require 'agate/src/apputil'

tc = require 'teacup'
{ make_field_input
  make_field_textarea } = require 'agate/src/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'
GpsChannel = Backbone.Radio.channel 'gps'


class BaseYardRoutineEditor extends BootstrapFormView
  fieldList: ['frequency', 'leeway', 'rate']
  templateContext: ->
    fieldList: @fieldList

  template: tc.renderable (model) ->
    tc.div '.listview-header', 'Yard Routine'
    for field in model.fieldList
      make_field_input(field)(model)
    make_field_textarea('description')(model)
    tc.input '.btn.btn-default', type:'submit', value:"Submit"
    tc.div '.spinner.fa.fa-spinner.fa-spin'
    
  ui: ->
    uiobject = make_field_input_ui @fieldList
    _.extend uiobject, {'description': 'textarea[name="description"]'}
    return uiobject
  
  # the model should be assigned in the controller
  createModel: ->
    @model
    
  updateModel: ->
    for field in @fieldList.concat ['description']
      value = @ui[field].val()
      console.log 'field', field, value
      if field is 'fullname' and not value
        console.log 'no fullname here.....'
        value = capitalize @model.get 'name' 
      @model.set field, value
    # update other fields
  
  saveNewModel: (objname) ->
    collection = SunnyChannel.request "#{objname}-collection"
    collection.add @model
    super
    
class YardRoutineInfo extends Backbone.Marionette.View
  template:  tc.renderable (model) ->
    tc.span "Routine:"
    if model?.yardroutines
      ytext = "We have a routine"
    else
      ytext = 'Not Set'
    tc.text ytext
    

class BaseYardRoutineView extends Backbone.Marionette.View
  template:  tc.renderable (model) ->
    #tc.span "Routine:"
    #if model?.yardroutines
    #  ytext = "We have a routine"
    #else
    #  ytext = 'Not Set'
    tc.div '#yard-routine-button.btn.btn-default.pull-right', ''
    tc.div "#yard-routine"

  regions:
    yardRoutine: '#yard-routine'
  ui: ->
    #yardRoutine: '#yard-routine'
    yardButton: '#yard-routine-button'
  events: ->
    'click @ui.yardButton': 'yard_button'

  currentRoutine: null
  
  yard_button: (event) ->
    routines = @model.get 'yardroutines'
    if routines
      console.log "we need to edit the routine", routines
    else
      console.log "create a new default routine"
      @createNewRoutine()
      

  createNewRoutine: ->
    routine = SunnyChannel.request 'new-yardroutine'
    routine.set 'yard_id', @model.id
    response = routine.save()
    response.done =>
      MessageChannel.request 'success', "Routine Created"
      controller = SunnyChannel.request 'main-controller'
      controller.view_yard @model.id
        
  setGettingLocationHtml: (source) ->
    @ui.yardLocation.html tc.render ->
      tc.span "getting location from #{source}......"
      tc.i '.fa.fa-spinner.fa-spin'


  addNewYard: ->
    console.log 'addNewYard'

  updateYardRoutine: ->
    console.log "update routine"

    
  saveCurrentRoutine: ->
    console.log 'save currentRoutine'
      

  onDomRefresh: ->
    console.log "onDomRefresh called"
    routines = @model.get 'yardroutines'
    if routines
      @ui.yardButton.text 'Edit Routine'
      @ui.yardRoutine.text "#{routines[0].routine_date}"
    else
      @ui.yardButton.text 'Set Default Routine'

    
    
module.exports = BaseYardRoutineView
  

