Util = require 'agate/src/apputil'

{ MainController } = require 'agate/src/controllers'
SidebarView = require 'agate/src/sidebarview'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'


side_bar_data = new Backbone.Model
  entries: [
    {
      name: 'Profile'
      url: '#profile'
    }
    {
      name: 'Map'
      url: '#profile/mapview'
    }
    {
      name: 'Settings'
      url: '#profile/editconfig'
    }
    {
      name: 'Change Password'
      url: '#profile/chpassword'
    }
    ]


class Controller extends MainController
  sidebarclass: SidebarView
  sidebar_model: side_bar_data
  
  show_profile: ->
    @setup_layout_if_needed()
    @_make_sidebar()
    require.ensure [], () =>
      ViewClass = require './mainview'
      # current-user is always there when app is
      # running
      user = MainChannel.request 'current-user'
      view = new ViewClass
        model: user
      @_show_content view
    # name the chunk
    , 'userprofile-view-show-profile'

  view_map: ->
    @setup_layout_if_needed()
    @_make_sidebar()
    require.ensure [], () =>
      ViewClass = require './mapview'
      # current-user is always there when app is
      # running
      user = MainChannel.request 'current-user'
      view = new ViewClass
        model: user
      @_show_content view
    # name the chunk
    , 'userprofile-view-map-view'

  edit_config: ->
    @setup_layout_if_needed()
    @_make_sidebar()
    require.ensure [], () =>
      ViewClass = require './configview'
      # current-user is always there when app is
      # running
      user = MainChannel.request 'current-user'
      view = new ViewClass
        model: user
      @_show_content view
    # name the chunk
    , 'userprofile-view-edit-config'
      
  change_password: ->
    @setup_layout_if_needed()
    @_make_sidebar()
    require.ensure [], () =>
      ViewClass = require './chpassview'
      # current-user is always there when app is
      # running
      user = MainChannel.request 'current-user'
      view = new ViewClass
        model: user
      @_show_content view
    # name the chunk
    , 'userprofile-view-chpasswd'
      
      
module.exports = Controller

