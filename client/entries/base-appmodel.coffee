$ = require 'jquery'
jQuery = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

{ BaseAppModel
  appregions } = require 'agate/src/appmodel'

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


appmodel = new BaseAppModel
  hasUser: true
  needUser: false
  brand:
    name: 'Infidel'
    url: '/'
  layout_template: layout_template
  container: 'container-fluid'
  regions: appregions
  navbar_viewclass: NavbarView
  
module.exports = appmodel
