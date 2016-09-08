Promise = require 'bluebird'
send = require 'send'        

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

db = require '../models'
sql = db.sequelize

APIPATH = config.apipath

ghost_auth = require 'ghost/core/server/middleware/auth'

auth = ghost_auth.authenticateUser
  
setup = (app) ->
  app.get "#{APIPATH}/dbadmin", auth, (req, res, next) ->
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

  app.put "#{APIPATH}/dbadmin", auth, (req, res, next) ->
    body = req.body
    if body.action is 'recreate_table'
      modelName = body.selected
      model = sql.models[modelName]
      model.sync
        force: true
      .then res.json
        result: 'success'

  app.get "#{APIPATH}/sunny/funny/clients", auth, (req, res, next) ->
    client = sql.models.sunnyclient
    client.findAndCountAll().then (result) ->
      res.json result
      
  app.get "#{APIPATH}/current-user", auth, (req, res, next) ->
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
      
  

module.exports =
  setup: setup
  
