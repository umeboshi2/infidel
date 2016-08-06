$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

{ BaseCollection } = require 'agate/src/collections'
{ create_model
  get_model } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
TodoChannel = Backbone.Radio.channel 'todos'


class Todo extends Backbone.Model
  urlRoot: '/api/dev/todos'

class TodoCollection extends Backbone.Collection
  url: '/api/dev/todos'
  model: Todo


todo_collection = new TodoCollection()
TodoChannel.reply 'todo-collection', ->
  todo_collection

if __DEV__
  window.todo_collection = todo_collection

TodoChannel.reply 'new-todo', ->
  new Todo

TodoChannel.reply 'add-todo', (options) ->
  create_model todo_collection, options

TodoChannel.reply 'get-todo', (id) ->
  get_model todo_collection, id


    
module.exports =
  TodoCollection: TodoCollection
