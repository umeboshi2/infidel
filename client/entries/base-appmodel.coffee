$ = require 'jquery'
jQuery = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

BaseAppModel = require 'agate/src/appmodel'
{ BootstrapModalRegion } = require 'agate/src/regions'

NavbarView = require './navbar'


tc = require 'teacup'

layout_template = tc.renderable () ->
  tc.div '#navbar-view-container'
  #tc.div '#editor-bar-container'
  tc.div ".container-fluid", ->
    tc.div '.row', ->
      tc.div '.col-sm-12', ->
        tc.div '#messages'
    tc.div '#applet-content.row'
  tc.div '#footer'
  tc.div '#modal'

class MainPageLayout extends Backbone.Marionette.View
  template: layout_template
  regions:
    messages: '#messages'
    navbar: '#navbar-view-container'
    modal: new BootstrapModalRegion
    applet: '#applet-content'
    footer: '#footer'
    

appmodel = new BaseAppModel
  hasUser: true
  needUser: false
  brand:
    name: 'Infidel'
    url: '/'
  appView: MainPageLayout
  navbarView: NavbarView

  #FIXME
  container: 'container-fluid'
  
module.exports = appmodel
