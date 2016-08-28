# inspired by
# https://github.com/eliias/backbone.oauth2

$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

get_client_info = ->
  id: $('meta[name="client-id"]').attr('value')
  secret: $('meta[name="client-secret"]').attr('value')

get_blog_session = ->
  JSON.parse localStorage.getItem 'ghost-blog:session'

make_auth_header = ->
  # retrieve from local storage on each request
  # to ensure current token
  s = get_blog_session().authenticated
  #console.log 'get_blog_session', s
  "#{s.token_type} #{s.access_token}"
  
send_auth_header = (xhr) ->
  xhr.setRequestHeader "Authorization", make_auth_header()


# The interval between two checks if token expires
# Default value is 60000 ms = 1 minute
# @type Number Time in ms
AUTO_REFRESH_TIME = 60000


class GhostAuth extends Marionette.Object
  tokenUrl: '/blog/ghost/api/v0.1/authentication/token'

  getTime: ->
    (new Date).getTime()
    
  state:
    #access_token: null
    #refresh_token: null
    #token_type: null
    #expires_in: null
    # 
    # expires_at is created on receiving access
    # and refreshing the token
    # Init at zero to presume unauthenticated
    expires_at: 0
    # authenticator is needed on ghost blog
    #authenticator: null

  load: ->
    #console.log "loading state"
    session = get_blog_session()
    #console.log 'session', session
    auth_state = session?.authenticated
    #console.log 'auth_state', auth_state
    if auth_state
      @state = auth_state
    @state

  save: (state) ->
    console.log "Saving state", state
    # state must have time set in it to evaluate expires_at
    starttime = state.time
    # delete time property to keep session.authenticated
    # similar to ghost
    delete state.time
    # Cast expires_in to Int and multiply by 1000 to get ms
    expires_in = parseInt(state.expires_in) * 1000
    state.expires_at = starttime + expires_in
    # authenticator is needed on ghost blog
    state.authenticator = 'authenticator:oauth2'
    # save refresh token
    unless state?.refresh_token
      console.log 'saving refresh token'
      state.refresh_token = @state.refresh_token
    @state = state
    session = get_blog_session() || {}
    session.authenticated = @state
    localStorage.setItem 'ghost-blog:session', JSON.stringify session

  isAuthenticated: ->
    @load()
    @getTime() < @state.expires_at
    

  expiresIn: ->
    if @isAuthenticated()
      @state.expires_at - @getTime()
    else
      0
    
  triggerRefresh: =>
    if @isAuthenticated()
      console.log 'triggerRefresh called'
      expires_in = @expiresIn() / 60000.0
      console.log "expires_in", expires_in
      if @expiresIn() <= 0
        console.log 'performing refresh', @isAuthenticated()
        @refresh()
        setTimeout @triggerRefresh, AUTO_REFRESH_TIME
        return
      setTimeout @triggerRefresh, AUTO_REFRESH_TIME
    else
      console.log 'performing refresh', @isAuthenticated()
      @refresh()
      setTimeout @triggerRefresh, AUTO_REFRESH_TIME
      
  sendAuthHeader: (xhr) ->
    send_auth_header xhr
    
  access: (username, password) ->
    if @isAuthenticated()
      return @trigger 'success', @state, @
    # save a reference to the current time before the request is
    # sent.  This assures us that we can set an expiration that
    # the server can agree with.
    time = @getTime()
    client = get_client_info()
    $.ajax
      url: @tokenUrl
      type: 'POST'
      data:
        grant_type: 'password'
        client_id: client.id
        client_secret: client.secret
        username: username
        password: password
      dataType: 'json'
      success: (response) =>
        response.time = time
        @save response
        @trigger 'refresh', response, this
      error: (response) =>
        console.log "error", response
        console.log response.responseJSON
        for error in response.responseJSON.errors
          MessageChannel.request 'warning', error.message

  refresh_success: (data, status, xhr) =>
    console.log "refresh->success", data
    console.log status
    data.time = time
    @save data
    @trigger 'refresh', response, this
    console.log "success", response
    
  refresh: ->
    console.log "refresh called"
    if @isAuthenticated()
      #return @trigger 'success', @state, @
      msg = 'No authentication data, use access method first.'
      console.log msg
      @trigger 'error', msg, @
    console.log "refresh starting.............."
    # save a reference to the current time before the request is
    # sent.  This assures us that we can set an expiration that
    # the server can agree with.
    time = @getTime()
    client = get_client_info()
    $.ajax
      url: @tokenUrl
      type: 'POST'
      data:
        grant_type: 'refresh_token'
        client_id: client.id
        client_secret: client.secret
        refresh_token: @state.refresh_token 
      dataType: 'json'
      headers: 'authorization', make_auth_header()
      # FIXME this is never called
      success: @refresh_success
      error: (response) ->
        console.log "refresh->ERROR", @
        self.trigger 'error', response, @
        return        
        
module.exports = GhostAuth
