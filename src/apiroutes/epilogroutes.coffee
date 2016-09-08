Promise = require 'bluebird'
epilogue = require 'epilogue'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

db = require '../models'
sql = db.sequelize

APIPATH = config.apipath

ghost_auth = require 'ghost/core/server/middleware/auth'

# FIXME this just determines if a user has
# passed a valid token, but the user isn't
# retrieved from database
api_auth = (req, res, context) ->
  new Promise (resolve, reject) ->
    ghost_auth.authenticateUser req, res, (err, user, info) ->
      if user?.id
        # FIXME get user and look at scope in info
        resolve context.continue
      else
        res.status(401).send
          message: 'Unauthorized'
        resolve context.stop

update_foreign_key = (req, res, context) ->
  console.log "update_foreign_key called", context
  context.options = {raw: true}
  context.attributes = { location_id: null }
  console.log "update_foreign_key called", context
  context.continue()
  
        
setup = (app) ->
  epilogue.initialize
    app: app
    sequelize: sql

  clientPath = "#{APIPATH}/sunny/clients"
  clientResource = epilogue.resource
    model: sql.models.sunnyclient
    endpoints: [clientPath, "#{clientPath}/:id"]
    associations: false
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      clientResource[f].auth api_auth 

  yardPath = "#{APIPATH}/sunny/yards"
  yardResource = epilogue.resource
    model: sql.models.yard
    endpoints: [yardPath, "#{yardPath}/:id"]
    associations: true
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      yardResource[f].auth api_auth
      #if f is 'update'
      #  yardResource[f].fetch.before update_foreign_key
        
  documentPath = "#{APIPATH}/sitedocuments"
  documentResource = epilogue.resource
    model: sql.models.document
    endpoints: [documentPath, "#{documentPath}/:id"]
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      documentResource[f].auth api_auth 

  todoPath = "#{APIPATH}/todos"
  todoResource = epilogue.resource
    model: sql.models.todo
    endpoints: [todoPath, "#{todoPath}/:id"]
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      todoResource[f].auth api_auth 
  
  geopositionPath = "#{APIPATH}/mappy/geopositions"
  geopositionResource = epilogue.resource
    model: sql.models.geoposition
    endpoints: [geopositionPath, "#{geopositionPath}/:id"]
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      geopositionResource[f].auth api_auth
      
      
  maplocationPath = "#{APIPATH}/mappy/maplocations"
  maplocationResource = epilogue.resource
    model: sql.models.maplocation
    endpoints: [maplocationPath, "#{maplocationPath}/:id"]
    associations: true
  for f in ['list', 'create', 'read', 'update', 'delete']
    do (f) ->
      maplocationResource[f].auth api_auth 
  

module.exports =
  setup: setup
  
