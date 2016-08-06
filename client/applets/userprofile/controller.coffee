Util = require 'agate/src/apputil'

{ MainController } = require 'agate/src/controllers'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class Controller extends MainController
  show_profile: ->
    console.log 'show_profile called.'
    require.ensure [], () =>
      ViewClass = require './mainview'
      # current-user is always there when app is
      # running
      user = MainChannel.request 'current-user'
      view = new ViewClass
        model: user
      @_show_content view
    # name the chunk
    , 'userprofile-view-profile'

  edit_config: ->
    console.log 'edit_config called.'
    require.ensure [], () =>
      ViewClass = require './configview'
      # current-user is always there when app is
      # running
      user = MainChannel.request 'current-user'
      view = new ViewClass
        model: user
      @_show_content view
    # name the chunk
    , 'userprofile-edit-config'
      
      
module.exports = Controller

