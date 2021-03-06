Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
Util = require 'agate/src/apputil'
tc = require 'teacup'
ms = require 'ms'

{ MainController } = require 'agate/src/controllers'
{ SlideDownRegion } = require 'agate/src/regions'

MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'

class AppletLayout extends Backbone.Marionette.View
  template: tc.renderable () ->
    tc.div '#main-content.col-sm-12'
  regions: ->
    region = new SlideDownRegion
      el: '#main-content'
    region.slide_speed = ms '.01s'
    content: region
  

class Controller extends MainController
  layoutClass: AppletLayout
  clients: SunnyChannel.request 'client-collection'
  
  list_clients: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      ListView = require './views/clientlist'
      view = new ListView
        collection: @clients
      response = @clients.fetch()
      response.done =>
        @_show_content view
      response.fail =>
        MessageChannel.request 'danger', "Failed to load clients."
    # name the chunk
    , 'sunny-view-list-clients'

  new_client: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { NewClientView } = require './views/clienteditor'
      @layout.showChildView 'content', new NewClientView
    # name the chunk
    , 'sunny-view-new-client'
      
  add_yard: (client_id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      YardView = require './views/yardview'
      # { NewYardView } = require './views/yardeditor'
      # view = new NewYardView
      model = SunnyChannel.request 'new-yard'
      model.set 'sunnyclient_id', client_id
      view = new YardView
        model: model
      @layout.showChildView 'content', view
    # name the chunk
    , 'sunny-view-add-yard'

  view_yard: (yard_id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      YardView = require './views/yardview'
      model = SunnyChannel.request 'get-yard', yard_id
      if model.has 'sunnyclient'
        @_show_edit_client YardView, model
      else
        response = model.fetch
          data:
            #"include[]": ['sunnyclient', 'geoposition']
            include: '*'
        response.done =>
          @_show_edit_client YardView, model
        response.fail =>
          MessageChannel.request 'danger', "Failed to load yard data."
    # name the chunk
    , 'sunny-view-yard-view'

  yard_routines: (yard_id) ->
    console.log 'yard_routines', yard_id
    
  _show_edit_client: (vclass, model) ->
    view = new vclass
      model: model
    @layout.showChildView 'content', view
    
  edit_client: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { EditClientView } = require './views/clienteditor'
      model = SunnyChannel.request 'get-client', id
      if model.has 'name'
        @_show_edit_client EditClientView, model
      else
        response = model.fetch()
        response.done =>
          @_show_edit_client EditClientView, model
        response.fail =>
          MessageChannel.request 'danger', "Failed to load client data."
    # name the chunk
    , 'sunny-view-edit-client'
      

  _fetch_yards_and_view_client: (client, viewclass) ->
    yards = SunnyChannel.request 'yard-collection'
    yresponse = yards.fetch
      data:
        sunnyclient_id: client.id
    yresponse.done =>
      view = new viewclass
        model: client
        collection: yards
      window.cview = view
      @layout.showChildView 'content', view
    yresponse.fail =>
      MessageChannel.request 'danger', 'Failed to load yards.'
    
      
  view_client: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      ClientMainView = require './views/viewclient'
      model = SunnyChannel.request 'get-client', id
      if model.has 'name'
        @_fetch_yards_and_view_client model, ClientMainView
      else
        response = model.fetch()
        response.done =>
          @_fetch_yards_and_view_client model, ClientMainView
        response.fail =>
          MessageChannel.request 'danger', "Failed to load client data."
    # name the chunk
    , 'sunny-view-client-view'
      
      
module.exports = Controller

  
