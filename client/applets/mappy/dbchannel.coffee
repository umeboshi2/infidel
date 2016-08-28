Backbone = require 'backbone'

{ make_dbchannel } = require 'agate/src/basecrudchannel'

MappyChannel = Backbone.Radio.channel 'mappy'

{ GhostModel
  GhostCollection } = require '../../ghost/base'


url = '/api/dev/mappy/gpslocations'
class GeoLocation extends GhostModel
  urlRoot: url

class GeoLocationCollection extends GhostCollection
  model: GeoLocation
  url: url

make_dbchannel MappyChannel, 'location', GeoLocation, GeoLocationCollection


