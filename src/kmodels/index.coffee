fs = require 'fs'
path = require 'path'
knex = require 'knex'

env = process.env.NODE_ENV or 'development'
#config = require('../../ghost-config')[env].database

#db = knex config
ghostdb = require 'ghost/core/server/data/db'

console.log "ghostdb", ghostdb



module.exports = ghostdb
