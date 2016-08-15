Backbone = require 'backbone'
{ navigate_to_url } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

get_blog_session = ->
  JSON.parse localStorage.getItem 'ghost-blog:session'

BlogSession = get_blog_session().authenticated


class AuthToken extends Backbone.Model
  url: '/blog/ghost/api/v0.1/authentication/token'


ghostusers_url = '/blog/ghost/api/v0.1/users/me?include=roles&status=all'
class GhostUser extends Backbone.Model
  url: ghostusers_url

  parse: (response) ->
    return response.users[0]
    

ghost_user = new GhostUser
MainChannel.reply 'current-user', ->
  ghost_user

send_auth_header = (xhr) ->
  s = BlogSession
  console.log 'get_blog_session', s
  value = "#{s.token_type} #{s.access_token}"
  console.log "auth value is", value
  xhr.setRequestHeader "Authorization", value
  
start_with_user = (app, url=ghostusers_url) ->
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
      navigate_to_url '/blog/ghost/signin'
      

module.exports =
  start_with_user: start_with_user

