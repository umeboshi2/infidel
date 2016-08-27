Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

{ MainController } = require 'agate/src/controllers'
{ login_form } = require 'agate/src/templates/forms'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'

tc = require 'teacup'

frontdoor_template = tc.renderable () ->
  tc.div '#main-content.col-sm-12'
  

class FrontdoorLayout extends Backbone.Marionette.LayoutView
  template: frontdoor_template
  regions:
    content: '#main-content'
    


class Controller extends MainController
  layoutClass: FrontdoorLayout
  
  _view_resource: (doc) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { FrontDoorMainView } = require './views'
      view = new FrontDoorMainView
        model: doc
      @_show_content view
      #applet.show view
    # name the chunk
    , 'frontdoor-main-view'
    

  _view_login: ->
    require.ensure [], () =>
      LoginView = require './loginview'
      view = new LoginView
      @_show_content view
    # name the chunk
    , 'frontdoor-login-view'
    
  view_page: (name) ->
    posts = MainChannel.request 'main:ghost:posts'
    response = posts.fetch
      data:
        slug: name
    response.done =>
      post = posts.find slug: name
      @_view_resource post
    response.fail =>
      MessageChannel.request 'danger', 'Failed to get document'
      

  frontdoor_needuser: ->
    user = MainChannel.request 'current-user'
    if user.has 'name'
      @frontdoor_hasuser user
    else
      @show_login()
      
  show_login: ->
    @_view_login()
    
  frontdoor_hasuser: (user) ->
    @default_view()

  default_view: ->
    @view_page 'welcome-to-ghost'
      
  frontdoor: ->
    @setup_layout_if_needed()
    appmodel = MainChannel.request 'main:app:appmodel'
    if appmodel.get 'needUser'
      console.log 'needUser is true'
      @frontdoor_needuser()
    else
      @default_view()

module.exports = Controller

