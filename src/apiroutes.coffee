Promise = require 'bluebird'
epilogue = require 'epilogue'

env = process.env.NODE_ENV or 'development'
config = require('./config')[env]

db = require './models'
sql = db.sequelize
UserAuth = require './userauth'

APIPATH = config.apipath

ghost_auth = require 'ghost/core/server/middleware/auth'

auth = ghost_auth.requiresAuthorizedUser

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
        
setup = (app) ->
  epilogue.initialize
    app: app
    sequelize: sql

  app.get "#{APIPATH}/dbadmin", (req, res, next) ->
    models =
      clients: 'client'
      yards: 'yard'
      todos: 'todo'
      documents: 'document'
    data =
      action: 'get'
      selected: null
      models: models
    res.json data

  app.put "#{APIPATH}/dbadmin", (req, res, next) ->
    body = req.body
    if body.action is 'recreate_table'
      modelName = body.selected
      model = sql.models[modelName]
      model.sync
        force: true
      .then res.json
        result: 'success'
  
  app.get "#{APIPATH}/current-user", (req, res, next) ->
    user = null
    if req?.user
      user = req.user
    res.json user

  app.put "#{APIPATH}/current-user", auth, (req, res, next) ->
    user = req.user
    model = sql.models.user
    #console.log 'user is', user
    #console.log 'req is', req
    console.log 'req.body is', req.body
    if 'config' of req.body
      user.update
        config: req.body.config
        where:
          id: user.id
      .then res.json
        result: 'success'
    else if 'password' of req.body
      user.update
        password: req.body.password
        where:
          id: user.id
      .then res.json
        result: 'success'
    else
      # FIXME, send properr status
      res.sendStatus(403)
      
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
  
