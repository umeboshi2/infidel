Promise = require 'bluebird'
epilogue = require 'epilogue'
express = require 'express'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

db = require '../models'
sql = db.sequelize

APIPATH = config.apipath

{ hasUserAuthEpilog } = require './base'

update_foreign_key = (req, res, context) ->
  console.log "update_foreign_key called", context
  context.options = {raw: true}
  context.attributes = { location_id: null }
  console.log "update_foreign_key called", context
  context.continue()

make_resource = (model, path, associations=false, id='id') ->
  resource = epilogue.resource
    model: model
    endpoints: [path, "#{path}/:#{id}"]
    associations: associations
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      resource[f].auth hasUserAuthEpilog 
  resource


router = express.Router()
epilogue.initialize
  app: router
  sequelize: sql
  
models = sql.models
  
clients = make_resource models.sunnyclient, '/sunny/clients' 
yards = make_resource models.yard, '/sunny/yards', true
documents = make_resource models.document, '/sitedocuments'
todos = make_resource models.todo, '/todos'
geopositions = make_resource models.geoposition, '/mappy/geopositions'
maplocations = make_resource models.maplocation, '/mappy/maplocations', true
yardroutines = make_resource models.yardroutine, '/sunny/yardroutines'

module.exports = router
  
