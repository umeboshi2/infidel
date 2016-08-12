_ = require 'underscore'
Backbone = require 'backbone'

#beautify = require('js-beautify').html

BootstrapFormView = require 'agate/src/bootstrap_formview'

{ navigate_to_url
  make_field_input_ui } = require 'agate/src/apputil'
HasAceEditor = require 'agate/src/acebehavior'

tc = require 'teacup'
{ make_field_input
  make_field_select } = require 'agate/src/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

EditForm = tc.renderable (model) ->
  tc.div '.listview-header', 'Document'
  for field in ['name', 'title', 'description']
    make_field_input(field)(model)
  make_field_select(field, ['html', 'markdown'])(model)
  tc.div '#ace-editor', style:'position:relative;width:100%;height:40em;'
  tc.input '.btn.btn-default', type:'submit', value:"Submit"
  tc.div '.spinner.fa.fa-spinner.fa-spin'
  

class BasePageEditor extends BootstrapFormView
  editorMode: 'html'
  editorContainer: 'ace-editor'
  fieldList: ['name', 'title', 'description']
  template: EditForm
  ui: ->
    uiobject = make_field_input_ui @fieldList
    _.extend uiobject, {'editor': '#ace-editor'}
    return uiobject
  
  behaviors:
    HasAceEditor:
      behaviorClass: HasAceEditor
      
  afterDomRefresh: () ->
    content = @model.get 'content'
    #content = beautify content
    @editor.setValue content

  updateModel: ->
    for field in ['name', 'title', 'description']
      @model.set field, @ui[field].val()
    # update from ace-editor
    @model.set 'content', @editor.getValue()

  onSuccess: (model) ->
    name = @model.get 'name'
    MessageChannel.request 'display-message', "#{name} saved successfully.", "success"
    
    
class NewPageView extends BasePageEditor
  createModel: ->
    ResourceChannel.request 'new-document'
    
  saveModel: ->
    docs = ResourceChannel.request 'document-collection'
    docs.add @model
    super

class EditPageView extends BasePageEditor
  # the model should be assigned in the controller
  createModel: ->
    #console.log "createModel called on EditPageView", @model
    @model
    
module.exports =
  NewPageView: NewPageView
  EditPageView: EditPageView
  

