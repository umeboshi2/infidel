# inspired by
# https://github.com/eliias/backbone.oauth2

$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

get_blog_session = ->
  JSON.parse localStorage.getItem 'ghost-blog:session'

get_refresh_token = ->
  s = get_blog_session()
  s.authenticated.refresh_token

make_auth_header = ->
  # retrieve from local storage on each request
  # to ensure current token
  s = get_blog_session().authenticated
  #console.log 'get_blog_session', s
  "#{s.token_type} #{s.access_token}"
  
send_auth_header = (xhr) ->
  xhr.setRequestHeader "Authorization", make_auth_header()

class GhostAuth extends Marionette.Object
  tokenUrl: '/blog/ghost/api/v0.1/authentication/token'

  state:
    access_token: null
    refresh_token: null
    token_type: null
    expires_at: null
    expires_in: null
    authenticator: null

  load: ->
    session = get_blog_session()
    auth_state = session.authenticated
    @state = auth_state
    @state

  save: (state) ->
    @state = state
    session = get_blog_session()
    session.authenticated = @state
    localStorage.setItem 'ghost-blog:session', session

  isAuthenticated: ->
    @load()
    (new Date).getTime() < @state.expires_at
    

  access: (username, password) ->
    if @isAuthenticated()
      return @trigger 'success', @state, @

    $.ajax
      url: @tokenUrl
      type: 'POST'
      data:
        grant_type: 'password'
        
