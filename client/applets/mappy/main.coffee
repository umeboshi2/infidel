BootStrapAppRouter = require 'agate/src/bootstrap_router'

require './dbchannel'
Controller = require './controller'


MainChannel = Backbone.Radio.channel 'global'
MappyChannel = Backbone.Radio.channel 'mappy'

class Router extends BootStrapAppRouter
  appRoutes:
    'mappy': 'main_view'
    #'mappy/mappy/new': 'new_todo'
    #'mappy/mappy/edit/:id': 'edit_todo'
    #'mappy/mappy/view/:id': 'view_todo'
        
    
MainChannel.reply 'applet:mappy:route', () ->
  controller = new Controller MainChannel
  MappyChannel.reply 'main-controller', ->
    controller
  router = new Router
    controller: controller
  if __DEV__
    #console.log controller
    window.scontroller = controller
  
