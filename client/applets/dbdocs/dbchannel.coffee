Backbone = require 'backbone'

{ BaseCollection } = require 'agate/src/collections'
{ make_dbchannel } = require 'agate/src/basecrudchannel'

ResourceChannel = Backbone.Radio.channel 'resources'

apipath = "/api/dev/sitedocuments"

class Document extends Backbone.Model
  urlRoot: apipath
  defaults:
    name: ''
    # doctype is either markdown or html
    doctype: 'markdown'
    title: ''
    content: ''
    description: ''
  
class DocumentCollection extends BaseCollection
  url: apipath
  model: Document

app_documents = new DocumentCollection()
ResourceChannel.reply 'app-documents', ->
  console.warn "DEPRECATED -> use document-collection request"
  app_documents
  
make_dbchannel ResourceChannel, 'document', Document, app_documents 

if __DEV__
  window.app_documents = app_documents

module.exports =
  DocumentCollection: DocumentCollection

