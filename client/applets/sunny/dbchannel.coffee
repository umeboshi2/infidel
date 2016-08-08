Backbone = require 'backbone'

{ BaseCollection } = require 'agate/src/collections'
{ make_dbchannel } = require 'agate/src/basecrudchannel'

SunnyChannel = Backbone.Radio.channel 'sunny'

url = '/api/dev/sunny/clients'
class Client extends Backbone.Model
  urlRoot: url

class ClientCollection extends Backbone.Collection
  model: Client
  url: url
  

sunny_clients = new ClientCollection()

make_dbchannel SunnyChannel, 'client', Client, sunny_clients  

if __DEV__
  window.sunny_clients = sunny_clients

class Yard extends Backbone.Model
  urlRoot: '/api/dev/sunny/yards'

class YardCollection extends Backbone.Collection
  model: Yard
  url: '/api/dev/sunny/yards'
  

sunny_yards = new YardCollection()

make_dbchannel SunnyChannel, 'yard', Client, sunny_clients  

class ClientYardCollection extends Backbone.Collection
  model: Yard
  url: ->
    "/api/dev/sunny/yards?client_id=#{@client_id}"
  
if __DEV__
  window.sunny_yards = sunny_yards


module.exports =
  ClientCollection: ClientCollection
  YardCollection: YardCollection
  ClientYardCollection: ClientYardCollection

