{ MainController } = require 'agate/src/controllers'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

class Controller extends MainController
  mainview: ->
    require.ensure [], () =>
      ViewClass = require './views'
      view = new ViewClass()
      @_show_content view
    # name the chunk
    , 'rezrov-views'
      

module.exports = Controller

