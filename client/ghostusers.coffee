$ = require 'jquery'
Backbone = require 'backbone'
{ navigate_to_url } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

get_blog_session = ->
  JSON.parse localStorage.getItem 'ghost-blog:session'

get_refresh_token = ->
  s = get_blog_session()
  s.authenticated.refresh_token

  
class AuthToken extends Backbone.Model
  url: '/blog/ghost/api/v0.1/authentication/token'

  refresh_token: ->
    @set 'grant_type', 'refresh_token'
    @set 'refresh_token', get_refresh_token()
    @set 'client_id', $('meta[name="client-id"]').attr('value')
    @set 'client_secret', $('meta[name="client-id"]').attr('value')
    
    
ghostusers_url = '/blog/ghost/api/v0.1/users/me?include=roles&status=all'
class GhostUser extends Backbone.Model
  url: ghostusers_url

  parse: (response) ->
    return response.users[0]
    

ghost_user = new GhostUser
MainChannel.reply 'current-user', ->
  ghost_user

send_auth_header = (xhr) ->
  # retrieve from local storage on each request
  # to ensure current token
  s = get_blog_session().authenticated
  console.log 'get_blog_session', s
  value = "#{s.token_type} #{s.access_token}"
  console.log "auth value is", value
  xhr.setRequestHeader "Authorization", value
  
start_with_user = (app, url=ghostusers_url) ->
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
  
  # fetch the authenticated user before starting the app
  #user = MainChannel.request 'create-current-user-object', url
  blog_session = get_blog_session()
  console.log 'blog_session', blog_session
  if blog_session and blog_session.authenticated
    user = MainChannel.request 'current-user'
    response = user.fetch
      beforeSend: send_auth_header
    response.done =>
      app.start()
    response.fail =>
      console.log "Response failed", response
      # FIXME do we ask for refresh?
      #navigate_to_url '/blog/ghost/signin'
      

module.exports =
  start_with_user: start_with_user

