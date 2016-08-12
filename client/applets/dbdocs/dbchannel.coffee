Backbone = require 'backbone'

{ make_dbchannel } = require 'agate/src/basecrudchannel'

ResourceChannel = Backbone.Radio.channel 'resources'

apipath = "/api/dev/sitedocuments"

class Document extends Backbone.Model
  urlRoot: apipath
  
class DocumentCollection extends Backbone.Collection
  url: apipath
  model: Document

make_dbchannel ResourceChannel, 'document', Document, DocumentCollection

module.exports =
  DocumentCollection: DocumentCollection

