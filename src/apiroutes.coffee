epilogue = require 'epilogue'

db = require './models'
sql = db.sequelize
UserAuth = require './userauth'

auth = UserAuth.auth
APIPATH = '/api/dev'

setup = (app) ->
  epilogue.initialize
    app: app
    sequelize: sql

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
    model: sql.models.client
    endpoints: [clientPath, "#{clientPath}/:id"]

  yardPath = "#{APIPATH}/sunny/yards"
  yardResource = epilogue.resource
    model: sql.models.yard
    endpoints: [yardPath, "#{yardPath}/:id"]

  documentPath = "#{APIPATH}/sitedocuments"
  documentResource = epilogue.resource
    model: sql.models.document
    endpoints: [documentPath, "#{documentPath}/:name"]

  todoPath = "#{APIPATH}/todos"
  todoResource = epilogue.resource
    model: sql.models.todo
    endpoints: [todoPath, "#{todoPath}/:name"]


module.exports =
  setup: setup
  
