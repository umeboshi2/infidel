BootStrapAppRouter = require 'agate/src/bootstrap_router'
{ create_new_approuter } = require 'agate/src/apputil'

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
  create_new_approuter MappyChannel, Router, Controller
  
