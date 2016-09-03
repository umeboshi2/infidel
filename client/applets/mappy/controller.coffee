Util = require 'agate/src/apputil'

{ MainController } = require 'agate/src/controllers'
{ SlideDownRegion } = require 'agate/src/regions'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
MappyChannel = Backbone.Radio.channel 'mappy'

tc = require 'teacup'

main_template = tc.renderable () ->
  tc.div '#main-content.col-sm-12'

class MappyLayout extends Backbone.Marionette.View
  template: main_template
  regions: ->
    content: new SlideDownRegion
      el: '#main-content'
      speed: 'slow'
  #regions:
  #  content: '#main-content'
  
  
class Controller extends MainController
  layoutClass: MappyLayout

  main_view: () ->
    @setup_layout()
    console.log 'layout should be ready'
    require.ensure [], () =>
      ViewClass = require './mapview'
      view = new ViewClass
      @layout.showChildView 'content', view
      #content = @layout.getRegion 'content'
      #content.empty()
      #content.show view
      #@_show_content view
      console.log 'view shown?', view
      
    # name the chunk
    , 'mappy-main-view'

      
module.exports = Controller

