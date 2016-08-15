Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

########################################
# User Menu Template
########################################
user_menu = tc.renderable (user) ->
  name = user.name
  tc.ul '#user-menu.ctx-menu.nav.navbar-nav', ->
    tc.li '.dropdown', ->
      tc.a '.dropdown-toggle', 'data-toggle':'dropdown', ->
        if name == undefined
          tc.text "Guest"
        else
          tc.text name
        tc.b '.caret'
      tc.ul '.dropdown-menu', ->
        tc.li ->
          tc.a href:'/blog', 'Blog'
        if name == undefined
          tc.li ->
            tc.a href:'/blog/ghost/signin', 'login'
        else
          tc.li ->
            tc.a href:'#profile', 'Profile Page'
          # we need a "get user info" from server
          # to populate this menu with 'admin' link
          # FIXME use "?." to help here
          admin = false
          unless name == undefined
            groups = user.groups
            if groups != undefined
              for g in groups
                if g.name == 'admin'
                  admin = true
          # FIXME I don't like using username
          for role in user.roles
            if role.name is 'Owner'
              admin = true
              break
          if admin
            tc.li ->
              href = '/admin'
              pathname = window.location.pathname
              if pathname.split(href)[0] == ''
                href = '#'
              tc.a href:href, 'Administer Site'
          tc.li ->
            tc.a href:'/logout', 'Logout'


class UserMenuView extends Backbone.Marionette.ItemView
  template: user_menu

module.exports = UserMenuView
