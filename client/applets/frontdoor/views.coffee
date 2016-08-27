Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
marked = require 'marked'

MainChannel = Backbone.Radio.channel 'global'

DefaultStaticDocumentTemplate = tc.renderable (post) ->
  tc.article '.document-view.content', ->
    tc.div '.body', ->
      tc.raw marked post.markdown

class FrontDoorMainView extends Backbone.Marionette.ItemView
  template: DefaultStaticDocumentTemplate

module.exports =
  FrontDoorMainView: FrontDoorMainView

