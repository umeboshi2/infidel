Promise = require 'bluebird'

miscApi = require './miscapi'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

db = require '../models'
sql = db.sequelize

APIPATH = config.apipath

ghost_auth = require 'ghost/core/server/middleware/auth'

auth = ghost_auth.requiresAuthorizedUser

# model routes
basicmodel = require './basicmodel'

        
setup = (app) ->
  app.use APIPATH, miscApi
  app.use "#{APIPATH}/basic", basicmodel

module.exports =
  setup: setup
  
