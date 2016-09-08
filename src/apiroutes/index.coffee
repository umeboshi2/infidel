Promise = require 'bluebird'

epilogRoutes = require './epilogroutes'
miscApi = require './miscapi'


env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

db = require '../models'
sql = db.sequelize

APIPATH = config.apipath

ghost_auth = require 'ghost/core/server/middleware/auth'

auth = ghost_auth.requiresAuthorizedUser

        
setup = (app) ->
  epilogRoutes.setup app
  miscApi.setup app
  
  

module.exports =
  setup: setup
  
