Promise = require 'bluebird'
express = require 'express'

ghost_auth = require 'ghost/core/server/middleware/auth'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]
db = require '../models'

sql = db.sequelize
APIPATH = config.apipath


# just simply check if user is authenticated
hasUserAuth = (req, res, next) ->
  ghost_auth.authenticateUser req, res, (err, user, info) ->
    if err
      next err
    else if user?.id
      next()
    else
      res.status(401).send
        message: 'Unauthorized'
        
        
# FIXME this just determines if a user has
# passed a valid token, but the user isn't
# retrieved from database
hasUserAuthEpilog = (req, res, context) ->
  new Promise (resolve, reject) ->
    ghost_auth.authenticateUser req, res, (err, user, info) ->
      if user?.id
        # FIXME get user and look at scope in info
        resolve context.continue
      else
        res.status(401).send
          message: 'Unauthorized'
        resolve context.stop

routemap =
  clients: 'client'
  yards: 'yard'
  todos: 'todo'
  yardroutines: 'yardroutine'
  sunnyclients: "sunnyclient"
  sitedocuments: 'document'

  
module.exports =
  hasUserAuth: hasUserAuth
  hasUserAuthEpilog: hasUserAuthEpilog
  routemap: routemap
  
  

  
