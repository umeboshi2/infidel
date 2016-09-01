Util = require 'agate/src/apputil'

{ MainController } = require 'agate/src/controllers'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
SunnyChannel = Backbone.Radio.channel 'sunny'


class Controller extends MainController
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
      { NewYardView } = require './views/yardeditor'
      view = new NewYardView
      view.client_id = client_id
      @layout.showChildView 'content', view
    # name the chunk
    , 'sunny-view-add-yard'
      

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
        client_id: client.id
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

