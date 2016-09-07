$ = require 'jquery'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

#if window.__agent
#  console.warn '__agent is present'
#  window.__agent.start Backbone, Marionette

  
require 'bootstrap'

UserMenuView = require './user-menu-view'

initialize_page = require 'agate/src/app-initpage'

#require 'agate/src/users'
{ start_with_user } = require '../ghost/users'

# FIXME
require '../ghost/posts'

require 'agate/src/clipboard'
require 'agate/src/messages'
require '../static-documents'
require '../datachannels/geopositions'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
DocChannel = Backbone.Radio.channel 'static-documents'


if __DEV__
  console.warn "__DEV__", __DEV__, "DEBUG", DEBUG
  Backbone.Radio.DEBUG = true
  #FIXME
  window.dchnnl = DocChannel

######################
# start app setup

MainChannel.reply 'mainpage:init', (appmodel) ->
  # get the app object
  app = MainChannel.request 'main:app:object'
  # initialize the main view
  initialize_page app
  # emit the main view is ready
  MainChannel.trigger 'mainpage:displayed'


MainChannel.on 'mainpage:displayed', ->
  # this handler is useful if there are views that need to be
  # added to the navbar.  The navbar should have regions to attach
  # the views
  # --- example ---
  # view = new view
  # aregion = MainChannel.request 'main:app:get-region', aregion
  # aregion.show view

  # current user should already be fetched before
  # any view is shown
  user = MainChannel.request 'current-user'
  view = new UserMenuView
    model: user
  app = MainChannel.request 'main:app:object'
  navbar = app.getView().getChildView('navbar')
  navbar.showChildView 'usermenu', view
  


module.exports =
  start_with_user: start_with_user
  
