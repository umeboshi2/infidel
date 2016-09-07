Backbone = require 'backbone'
Templates = require 'agate/src/templates/basecrud'
Views = require 'agate/src/basecrudviews'
tc = require 'teacup'

MessageChannel = Backbone.Radio.channel 'messages'
TodoChannel = Backbone.Radio.channel 'todos'

base_item_template = (name, route_name) ->
  tc.renderable (model) ->
    item_btn = ".btn.btn-default.btn-xs"
    tc.li ".list-group-item.#{name}-item", ->
      tc.span ->
        tc.a href:"##{route_name}/#{name}s/view/#{model.id}", model.name
        
      tc.div '.todo-completed.checkbox.pull-right', ->
        tc.label ->
          tc.input '.todo-checkbox', type:'checkbox', checked:model.completed
          tc.text 'done'
        
class ItemView extends Views.BaseItemView
  route_name: 'todos'
  template: base_item_template 'todo', 'todos'
  item_type: 'todo'
  ui:
    edit_item: '.edit-item'
    delete_item: '.delete-item'
    item: '.list-item'
    completed: '.todo-checkbox'
    
  events: ->
    'click @ui.edit_item': 'edit_item'
    'click @ui.delete_item': 'delete_item'
    'change @ui.completed': 'todo_completed'
    
  edit_item: ->
    navigate_to_url "##{@route_name}/#{@item_type}s/edit/#{@model.id}"
    
  delete_item: ->
    if __DEV__
      console.log "delete_#{@item_type}", @model
    view = new ConfirmDeleteModal
      model: @model
    if __DEV__
      console.log 'modal view', view
    show_modal view, true

  todo_completed: (event) ->
    @model.set 'completed', event.target.checked
    response = @model.save()
    response.done =>
      MessageChannel.request 'success', "Updated #{@model.get 'name'}"
      controller = TodoChannel.request 'main-controller'
      controller.list_certain_todos not event.target.checked
      
  
class ListView extends Views.BaseListView
  route_name: 'todos'
  childView: ItemView
  template: Templates.base_list_template 'todo'
  childViewContainer: '#todo-container'
  item_type: 'todo'
    
module.exports = ListView

