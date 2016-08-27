$ = require 'jquery'
Backbone = require 'backbone'
{ navigate_to_url } = require 'agate/src/apputil'

GhostAuth = require './ghostauth'
# FIXME: find a better place 
{ GhostModel
  GhostCollection } = require './ghostusers'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'


posts_url = '/blog/ghost/api/v0.1/posts'
class GhostPost extends GhostModel
  urlRoot: posts_url

class GhostPostCollection extends GhostCollection
  model: GhostPost
  url: posts_url

  parse: (response) ->
    if response?.meta?.pagination
      @pagination = response.meta.pagination
    super response.posts
    

posts_collection = new GhostPostCollection
MainChannel.reply 'main:ghost:posts', ->
  posts_collection
      

module.exports = null
