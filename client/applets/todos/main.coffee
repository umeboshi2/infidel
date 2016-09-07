BootStrapAppRouter = require 'agate/src/bootstrap_router'

require './dbchannel'
Controller = require './controller'


MainChannel = Backbone.Radio.channel 'global'
TodoChannel = Backbone.Radio.channel 'todos'

class Router extends BootStrapAppRouter
  appRoutes:
    'todos': 'list_todos'
    'todos/completed': 'list_completed_todos'
    'todos/todos/new': 'new_todo'
    'todos/todos/edit/:id': 'edit_todo'
    'todos/todos/view/:id': 'view_todo'
        
    
MainChannel.reply 'applet:todos:route', () ->
  controller = new Controller MainChannel
  TodoChannel.reply 'main-controller', ->
    controller
  router = new Router
    controller: controller
  if __DEV__
    #console.log controller
    window.scontroller = controller
  
