{ MainController } = require 'agate/src/controllers'


MainChannel = Backbone.Radio.channel 'global'
MessageChannel = Backbone.Radio.channel 'messages'
ResourceChannel = Backbone.Radio.channel 'resources'

class Controller extends MainController
  collection: ResourceChannel.request 'document-collection'
  
  list_pages: () ->
    @setup_layout_if_needed()
    console.log "List Pages"
    require.ensure [], () =>
      ListView = require './views/pagelist'
      view = new ListView
        collection: @collection
      response = @collection.fetch()
      response.done =>
        @_show_content view
      response.fail =>
        MessageChannel.request 'danger', "Failed to load documents."
    # name the chunk
    , 'dbdocs-view-list-pages'

  edit_page: (id) ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { EditPageView } = require './views/editor'
      model = ResourceChannel.request 'get-document', id
      @_load_view EditPageView, model
    # name the chunk
    , 'dbdocs-view-edit-page'
      
  new_page: () ->
    @setup_layout_if_needed()
    require.ensure [], () =>
      { NewPageView } = require './views/editor'
      @_show_content new NewPageView
    # name the chunk
    , 'dbdocs-view-new-page'
      
      
module.exports = Controller

