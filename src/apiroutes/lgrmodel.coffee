Promise = require 'bluebird'
express = require 'express'

db = require '../models'
{ hasUserAuth } = require './base'
routemap = require('./routemap').lgrmodel


sql = db.sequelize
router = express.Router()

Model = sql.models.yard

ignored_fields = ['id', 'created_at', 'updated_at']


#router.use hasUserAuth

router.param 'models', (req, res, next, value) ->
  console.log value, '-->', routemap[value]
  req.ModelClass = sql.models[routemap[value]]
  req.ModelRoute = value
  next()
    
router.get '/:models', (req, res) ->
  console.log ':models', req.ModelRoute
  console.log sql.models[routemap[req.ModelRoute]]
  
  
  req.ModelClass.findAll
    attributes:
      exclude: ['createdAt', 'updatedAt']
    where: req.query
  .then (result) ->
    res.json result

router.get '/:models/include', (req, res) ->
  includes = []
  for rel of req.ModelClass.associations
    includes.push req.ModelClass.associations[rel]
  req.ModelClass.findAll
    attributes:
      exclude: ['createdAt', 'updatedAt']
    where: req.query
    include: includes
  .then (result) ->
    res.json result

router.get "/:models/hubcal", (req, res) ->
  req.ModelClass.findAll
    attributes:
      exclude: ['createdAt', 'updatedAt']
    where:
      date:
        $between: [req.query.start, req.query.end]
  .then (rows) ->
    cal_events = []
    for model in rows
      item =
        id: model.id
        start: model.date
        end: model.date
      if 'name' of model
        item.title = model.name
      else if 'title' of model
        item.title = model.title
      else
        item.title = "#{req.ModelRoute}-#{item.id}"
      cal_events.push item
    res.json cal_events

router.get "/:models/create-cal", (req, res) ->
  req.ModelClass.findAll
    where:
      created_at:
        $between: [req.query.start, req.query.end]
  .then (rows) ->
    cal_events = []
    for model in rows
      item =
        id: model.id
        start: model.created_at
        end: model.created_at
      if 'name' of model
        item.title = model.name
      else if 'title' of model
        item.title = model.title
      else
        item.title = "#{req.ModelRoute}-#{item.id}"
      cal_events.push item
    res.json cal_events


router.param 'id', (req, res, next, value) ->
  options =
    attributes:
      exclude: ['createdAt', 'updatedAt']
    where:
      id: req.params.id
  if 'include' of req.query
    console.log "req.query", req.query
    console.log "req.query.include", req.query.include
    includes = []
    if req.query.include is '*'
      for rel of req.ModelClass.associations
        includes.push req.ModelClass.associations[rel]
      options.include = includes
    else
      for rel in req.query.include
        includes.push req.ModelClass.associations[rel]
      options.include = includes
    console.log 'ModelClass', req.ModelClass, options
  req.ModelClass.find options
  .then (model) ->
    req.model = model
    next()
    
  
router.get '/:models/:id', (req, res) ->
  res.json req.model


module.exports = router

  
