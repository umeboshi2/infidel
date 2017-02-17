Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

{ MainController } = require 'agate/src/controllers'
{ login_form } = require 'agate/src/templates/forms'
{ SlideDownRegion } = require 'agate/src/regions'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
HubChannel = Backbone.Radio.channel 'hubby'
DocChannel = Backbone.Radio.channel 'static-documents'

tc = require 'teacup'

frontdoor_template = tc.renderable () ->
  tc.div '#header-stuff.row'
  tc.div '.row', ->
    tc.div '.col-sm-4', ->
      tc.div '#calendar.mini-calendar.panel'
    tc.div '#main-content.col-sm-8'
    tc.div '#meeting-info.col-sm-8.col-sm-offset-4'
    
    
class FrontdoorLayout extends Backbone.Marionette.View
  template: frontdoor_template
  regions: ->
    content: new SlideDownRegion
      el: '#main-content'
      speed: 'slow'
    minicalendar: '#calendar'
    meeting: '#meeting-info'
    

class Controller extends MainController
  layoutClass: FrontdoorLayout
  
  _view_resource: (doc) ->
    require.ensure [], () =>
      { FrontDoorMainView } = require './views'
      view = new FrontDoorMainView
        model: doc
      @layout.showChildView 'content', view
    # name the chunk
    , 'frontdoor-view-page'
    

  _view_login: ->
    require.ensure [], () =>
      LoginView = require './loginview'
      view = new LoginView
      @layout.showChildView 'content', view
      #@_show_content view
    # name the chunk
    , 'frontdoor-login-view'
    
  view_blog_page: (name) ->
    posts = MainChannel.request 'main:ghost:posts'
    response = MainChannel.request 'main:ghost:get-post', name
    response.done =>
      post = posts.find slug: name
      @_view_resource post
    response.fail =>
      MessageChannel.request 'danger', 'Failed to get document'
      

  view_page: (name) ->
    doc = DocChannel.request 'get-document', name
    response = doc.fetch()
    response.done =>
      @_view_resource doc
    response.fail =>
      MessageChannel.request 'danger', 'Failed to get document'

  frontdoor_needuser: ->
    user = MainChannel.request 'current-user'
    if user.has 'name'
      @frontdoor_hasuser user
    else
      @show_login()
      
  show_login: ->
    @setup_layout_if_needed()
    @_view_login()
    
  frontdoor_hasuser: (user) ->
    @default_view()

  default_view: ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { PostList } = require './views'
      @view_page 'intro'
      HubChannel.request 'view-calendar', @layout, 'minicalendar'
    , 'frontdoor-default-view'
    
  frontdoor: ->
    appmodel = MainChannel.request 'main:app:appmodel'
    if appmodel.get 'needUser'
      @frontdoor_needuser()
    else
      @default_view()

module.exports = Controller

