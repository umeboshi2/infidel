Util = require 'agate/src/apputil'

{ MainController } = require 'agate/src/controllers'
SidebarView = require 'agate/src/sidebarview'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
TodoChannel = Backbone.Radio.channel 'todos'

side_bar_data = new Backbone.Model
  entries: [
    {
      name: 'List'
      url: '#todos'
    }
    {
      name: 'Calendar'
      url: '#todos/calendar'
    }
    {
      name: 'Complete'
      url: '#todos/completed'
    }
    ]

class Controller extends MainController
  sidebarclass: SidebarView
  sidebar_model: side_bar_data
  collection: TodoChannel.request 'todo-collection'

  setup_layout_if_needed: ->
    super()
    @_make_sidebar()

  _load_view: (vclass, model, objname) ->
    # FIXME
    # presume "id" is only attribute there if length is 1
    #if model.isEmpty() or Object.keys(model.attributes).length is 1
    if model.isEmpty() or not model.has 'created_at'
      response = model.fetch()
      response.done =>
        @_show_view vclass, model
      response.fail =>
        msg = "Failed to load #{objname} data."
        MessageChannel.request 'danger', msg
    else
      @_show_view vclass, model
    
  
  list_certain_todos: (completed) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      ListView = require './views/todolist'
      view = new ListView
        collection: @collection
      response = @collection.fetch
        data:
          completed: completed
      response.done =>
        @_show_content view
      response.fail =>
        MessageChannel.request 'danger', "Failed to load todos."
    # name the chunk
    , 'todos-list-todos'

  list_completed_todos: () ->
    @list_certain_todos true

  list_todos: () ->
    @list_certain_todos false

  new_todo: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { NewView } = require './views/editor'
      @_show_content new NewView
    # name the chunk
    , 'todos-new-todo'

  edit_todo: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { EditView } = require './views/editor'
      model = TodoChannel.request 'get-todo', id
      @_load_view EditView, model, 'todo'
    # name the chunk
    , 'todos-edit-todo'
      
  view_todo: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      MainView = require './views/viewtodo'
      model = TodoChannel.request 'get-todo', id
      @_load_view MainView, model, 'todo'
    # name the chunk
    , 'todos-view-todo'
      
  view_calendar: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      View = require './views/todocal'
      @layout.showChildView 'content', new View
    # name the chunk
    , 'todos-view-calendar'
      
      
module.exports = Controller

