BootStrapAppRouter = require 'agate/src/bootstrap_router'

require './dbchannel'
Controller = require './controller'

MainChannel = Backbone.Radio.channel 'global'
ResourceChannel = Backbone.Radio.channel 'resources'



class Router extends BootStrapAppRouter
  appRoutes:
    'dbdocs': 'list_pages'
    'dbdocs/documents/new': 'new_page'
    'dbdocs/documents/edit/:id': 'edit_page'
    
MainChannel.reply 'applet:dbdocs:route', () ->
  controller = new Controller MainChannel
  router = new Router
    controller: controller

