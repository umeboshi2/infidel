{ start_with_user } = require './base'
Marionette = require 'backbone.marionette'
prepare_app = require 'agate/src/app-prepare'

appmodel = require './base-appmodel'
#appmodel.set 'applets',
applets = 
  [
    {
      appname: 'hubby'
      name: 'Hubby'
      url: '#hubby'
    }
    {
      appname: 'sunny'
      name: 'Sunny'
      url: '#sunny'
    }
    {
      appname: 'bumblr'
      name: 'Bumblr'
      url: '#bumblr'
    }
    {
      appname: 'todos'
      name: 'Todos'
      url: '#todos'
    }
    {
      appname: 'userprofile'
      name: 'Profile Page'
      url: '#profile'
    }
    {
      appname: 'dbdocs'
      name: 'DB Docs'
      url: '#dbdocs'
    }
    {
      appname: 'mappy'
      name: 'Map'
      url: '#mappy'
    }
  ]
appmodel.set 'applets', applets

brand = appmodel.get 'brand'
brand.url = '#'
appmodel.set brand: brand
  
MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
DocChannel = Backbone.Radio.channel 'static-documents'

sunny_entry =
  label: 'Sunny'
  applets: ['sunny', 'todos', 'dbdocs']
  single_applet: false

applet_menus = [
  sunny_entry
  {
    label: 'Hubby'
    single_applet: 'hubby'
    url: '#hubby'
  }
  {
    label: 'Blog'
    single_applet: false
    url: '/blog'
  }
  {
    label: 'Stuff'
    single_applet: false
    applets: ['mappy', 'bumblr', 'userprofile']
  }
  ]

appmodel.set 'applet_menus', applet_menus

#applets = {}
#for applet in appmodel.get 'applets'
#  applets[applet.appname] = applet
  

# use a signal to request appmodel
MainChannel.reply 'main:app:appmodel', ->
  appmodel

######################
# require applets
#require 'agate/src/applets/frontdoor/main'
require '../applets/frontdoor/main'
require '../applets/userprofile/main'
require '../applets/bumblr/main'
require '../applets/mappy/main'
require '../applets/mappy/main'

require '../applets/sunny/main'
require '../applets/hubby/main'
require '../applets/dbdocs/main'
require '../applets/todos/main'

#app = new Marionette.Application()

app = prepare_app appmodel

if __DEV__
  # DEBUG attach app to window
  window.App = app

# start the app
start_with_user app


module.exports = app


