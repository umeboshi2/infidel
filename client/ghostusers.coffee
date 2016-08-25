$ = require 'jquery'
Backbone = require 'backbone'
{ navigate_to_url } = require 'agate/src/apputil'

GhostAuth = require './ghostauth'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

############################################
# FIXME adjust original auth/refresh policy
############################################
# get the blog_session from local storage
# look at the time left on the key
# if it is less than 15min (or something) then
# make a refresh token request
# otherwise, set a timer for that 15min to
# make the post request to get another token
# and store the results in local storage

# If it is still time for a refresh, do the
# refresh request, store the new tokens, then
# start the pate
#
# If there is no time left for the token,
# either display the page, or redirect to
# login.
# 
############################################

ghostusers_url = '/blog/ghost/api/v0.1/users/me?include=roles&status=all'
class GhostUser extends Backbone.Model
  url: ghostusers_url

  parse: (response) ->
    return response.users[0]
    

ghost_user = new GhostUser
MainChannel.reply 'current-user', ->
  ghost_user


auth = new GhostAuth
MainChannel.reply 'main:app:ghostauth', ->
  auth

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
  
start_with_user = (app) ->
  console.log 'start_with_user'
  console.log 'auth', auth
  if auth.isAuthenticated()
    auth.triggerRefresh()
    # fetch the authenticated user before starting the app
    user = MainChannel.request 'current-user'
    # FIXME add auth to models (or sendAuthHeader)
    response = user.fetch
      beforeSend: auth.sendAuthHeader
    response.done =>
      app.start()
    response.fail =>
      # FIXME make better failure response
      console.log "Response failed", response
  # check is session.authenticated is {}    
  else if not Object.keys(auth.state).length
    app.start()
  # FIXME 
  else if not auth.state.expires_in
    app.start()
  else if auth.expiresIn() <= 0
    time = auth.getTime()
    #auth.triggerRefresh()
    console.log 'auth.refresh', auth.state
    res = auth.refresh()
    console.log 'res', res
    res.done =>
      data = res.responseJSON
      data.time = time
      auth.save res.responseJSON
      auth.triggerRefresh()
      user = MainChannel.request 'current-user'
      ures = user.fetch
        beforeSend: auth.sendAuthHeader
      ures.done =>
        app.start()
        
    #res.then =>
    #  res.success res.responseJSON
    #  console.log 'res.done', auth.state, res
    #  user = MainChannel.request 'current-user'
    #  ures = user.fetch
    #    beforeSend: auth.sendAuthHeader
    #  ures.done =>
    #    app.start()
    #  ures.fail =>
    #    console.error 'Response failed', ures
    #res.error =>
    #  app.start()
    #  MessageChannel.request 'warn', 'Failed to authenticate.'
      
      

module.exports =
  start_with_user: start_with_user
  GhostModel: GhostModel
  GhostCollection: GhostCollection
  
