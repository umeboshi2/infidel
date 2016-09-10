express = require 'express'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

db = require '../models'
sql = db.sequelize

APIPATH = config.apipath

{ hasUserAuth } = require './base'

router = express.Router()
  
router.get "/dbadmin", hasUserAuth, (req, res, next) ->
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

router.put "/dbadmin", hasUserAuth, (req, res, next) ->
  body = req.body
  if body.action is 'recreate_table'
    modelName = body.selected
    model = sql.models[modelName]
    model.sync
      force: true
    .then res.json
      result: 'success'

router.get "/sunny/funny/clients", hasUserAuth, (req, res, next) ->
  client = sql.models.sunnyclient
  client.findAndCountAll().then (result) ->
    res.json result

router.get "/sunny/funny/todocal", hasUserAuth, (req, res, next) ->
  todo = sql.models.todo
  where =
    created_at:
      $gte: req.query.start
    updated_at:
      $lte: req.query.end
  todo.findAll
    where: where
  .then (result) ->
    items = []
    for todo in result
      item =
        id: todo.id
        start: todo.created_at
        end: todo.created_at
        title: todo.name
        completed: todo.completed
      items.push item
    res.json items
        
router.get "/current-user", hasUserAuth, (req, res, next) ->
  user = null
  if req?.user
    user = req.user
  res.json user

router.put "/current-user", hasUserAuth, (req, res, next) ->
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
      
  

module.exports = router
  
