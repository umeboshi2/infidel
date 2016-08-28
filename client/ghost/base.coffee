Backbone = require 'backbone'

MainChannel = Backbone.Radio.channel 'global'

ghost_sync_options = (options) ->
  auth = MainChannel.request 'main:app:ghostauth'
  console.log 'auth auth', auth
  options = options || {}
  options.beforeSend = auth.sendAuthHeader
  console.log "sync", options
  options

class GhostModel extends Backbone.Model
  sync: (method, model, options) ->
    options = ghost_sync_options options
    super method, model, options

class GhostCollection extends Backbone.Collection
  sync: (method, model, options) ->
    options = ghost_sync_options options
    super method, model, options
  
module.exports =
  GhostModel: GhostModel
  GhostCollection: GhostCollection
  
