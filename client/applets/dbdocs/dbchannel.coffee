Backbone = require 'backbone'

{ GhostModel
  GhostCollection } = require '../../ghost/base'

{ make_dbchannel } = require 'agate/src/basecrudchannel'

ResourceChannel = Backbone.Radio.channel 'resources'

apipath = "/api/dev/sitedocuments"

class Document extends GhostModel
  urlRoot: apipath
  
class DocumentCollection extends GhostCollection
  url: apipath
  model: Document

make_dbchannel ResourceChannel, 'document', Document, DocumentCollection

module.exports =
  DocumentCollection: DocumentCollection

