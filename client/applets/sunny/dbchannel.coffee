Backbone = require 'backbone'

{ make_dbchannel } = require 'agate/src/basecrudchannel'

# FIXME: find a better place 
{ GhostModel
  GhostCollection } = require '../../ghost/users'
  

MainChannel = Backbone.Radio.channel 'global'
SunnyChannel = Backbone.Radio.channel 'sunny'


url = '/api/dev/sunny/clients'
class Client extends GhostModel
  urlRoot: url
    
class ClientCollection extends GhostCollection
  model: Client
  url: url

  

make_dbchannel SunnyChannel, 'client', Client, ClientCollection
  
url = '/api/dev/sunny/yards'
class Yard extends Backbone.Model
  urlRoot: url

class YardCollection extends Backbone.Collection
  model: Yard
  url: url
  
make_dbchannel SunnyChannel, 'yard', Yard, YardCollection

module.exports =
  ClientCollection: ClientCollection
  YardCollection: YardCollection

