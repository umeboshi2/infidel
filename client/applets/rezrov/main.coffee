BootStrapAppRouter = require 'agate/src/bootstrap_router'

Controller = require './controller'


MainChannel = Backbone.Radio.channel 'global'

class Router extends BootStrapAppRouter
  appRoutes:
    'rezrov': 'mainview'

MainChannel.reply 'applet:rezrov:route', () ->
  controller = new Controller MainChannel
  router = new Router
    controller: controller

