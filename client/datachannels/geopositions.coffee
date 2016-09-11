Backbone = require 'backbone'

{ make_dbchannel } = require 'agate/src/basecrudchannel'
{ get_model } = require 'agate/src/apputil'

GpsChannel = Backbone.Radio.channel 'gps'

{ GhostModel
  GhostCollection } = require '../ghost/base'
  
make_dbchannel = (channel, objname, modelClass, collectionClass) ->
  collection = new collectionClass
  channel.reply "#{objname}-collection", ->
    collection
  channel.reply "new-#{objname}", ->
    new modelClass
  channel.reply "add-#{objname}", (options) ->
    create_model collection options
  channel.reply "get-#{objname}", (id) ->
    get_model collection, id


url = '/api/dev/basic/geopositions'
class GeoPosition extends GhostModel
  urlRoot: url

class GeoPositionCollection extends GhostCollection
  model: GeoPosition
  url: url

make_dbchannel GpsChannel, 'position', GeoPosition, GeoPositionCollection


