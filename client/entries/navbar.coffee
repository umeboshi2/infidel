tc = require 'teacup'

{ navbar_collapse_button
  dropdown_toggle } = require 'agate/src/templates/buttons'

nav_pt_content_orig = tc.renderable (appmodel) ->
  tc.div ".#{appmodel.container or 'container'}", ->
    tc.div '.navbar-header', ->
      navbar_collapse_button 'navbar-view-collapse'
      tc.a '.navbar-brand', href:appmodel.brand.url, appmodel.brand.name
    tc.div '#navbar-view-collapse.collapse.navbar-collapse', ->
      tc.ul '.nav.navbar-nav.nav-pills', ->
        applets = {}
        for applet in appmodel.applets
          applets[applet.appname] = applet
        #console.log "applets", applets
        for entry in appmodel.applet_menus
          #console.log 'menu entry', entry
          if entry?.applets
            tc.li '.dropdown', ->
              tc.a '.dropdown-toggle', 'data-toggle':'dropdown', ->
                tc.text entry.label
                tc.b '.caret'
              tc.ul '.dropdown-menu', ->
                for appname in entry.applets
                  tc.li appname:applets[appname].appname, ->
                    tc.a href:applets[appname].url, applets[appname].name
          else
            tc.li ->
              tc.a href:entry.url, entry.label
      tc.ul '#user-menu.nav.navbar-nav.navbar-right'
      tc.div '#form-search-container'

nav_pt_content = tc.renderable (appmodel) ->
  tc.div ".#{appmodel.container or 'container'}", ->
    tc.div '.navbar-header', ->
      navbar_collapse_button 'navbar-view-collapse'
      tc.a '.navbar-brand', href:appmodel.brand.url, appmodel.brand.name
    tc.div '#navbar-view-collapse.collapse.navbar-collapse', ->
      tc.ul '#applet-menus.nav.navbar-nav.nav-pills'
      tc.ul '#user-menu.nav.navbar-nav.navbar-right'
      tc.div '#form-search-container'

navbar_template = tc.renderable (appmodel) ->
  #tc.nav '#navbar-view.navbar.navbar-static-top.navbar-inverse',
  tc.nav '#navbar-view.navbar.navbar-static-top.navbar-default',
  xmlns:'http://www.w3.org/1999/xhtml', 'xml:lang':'en',
  role:'navigation', ->
    nav_pt_content_orig appmodel

class NavbarView extends Backbone.Marionette.View
  template: navbar_template
  regions:
    #navbarview: '#navbar-view'
    appletmenus: '#applet-menus'
    usermenu: '#user-menu'
    mainmenu: '#main-menu'
    
########################################
module.exports = NavbarView
