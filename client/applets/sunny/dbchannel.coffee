Backbone = require 'backbone'

{ make_dbchannel } = require 'agate/src/basecrudchannel'

{ GhostModel
  GhostCollection } = require '../../ghost/base'
  

MainChannel = Backbone.Radio.channel 'global'
SunnyChannel = Backbone.Radio.channel 'sunny'


url = '/api/dev/basic/sunnyclients'
class Client extends GhostModel
  urlRoot: url
    
class Clients extends GhostCollection
  model: Client
  url: url



make_dbchannel SunnyChannel, 'client', Client, Clients
  
url = '/api/dev/basic/yards'
class Yard extends GhostModel
  urlRoot: url

class Yards extends GhostCollection
  model: Yard
  url: url
  
make_dbchannel SunnyChannel, 'yard', Yard, Yards

url = '/api/dev/basic/yardroutines'
class YardRoutine extends GhostModel
  urlRoot: url
  defaults: ->
    frequency: 14
    leeway: 3
    rate: 50
    active: true
    routine_date: new Date()
      

class YardRoutines extends GhostCollection
  model: YardRoutine
  url: url

make_dbchannel SunnyChannel, 'yardroutine', YardRoutine, YardRoutines
  

url = '/api/dev/basic/yardroutinejobs'
class YardRoutineJob extends GhostModel
  urlRoot: url

class YardRoutineJobs extends GhostCollection
  model: YardRoutineJob
  url: url

make_dbchannel SunnyChannel, 'yardroutinejob', YardRoutineJob, YardRoutineJobs


module.exports =
  Clients: Clients
  Yards: Yards
  YardRoutines: YardRoutines
  YardRoutineJobs: YardRoutineJobs
  

