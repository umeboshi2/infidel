fs = require 'fs'
path = require 'path'
Sequelize = require 'sequelize'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

sequelize = new Sequelize(config.database, config.username, config.password, config)
db = {}

# import models
sequelize.import './userconfig'
sequelize.import './document'
sequelize.import './todo'
sequelize.import './geoposition'
sequelize.import './maplocation'

sequelize.import './sunnyclient'
sequelize.import './yard'
sequelize.import './yardroutine'
sequelize.import './yardroutinejob'
sequelize.import './singleyardjob'
sequelize.import './singleclientjob'

# setup associations
sql = sequelize

#sql.models.yard.belongsTo sql.models.sunnyclient,
#  foreignKey: 'client_id'
#  targetKey: 'id'

# FIXME, are these two associations equivalent?
sql.models.sunnyclient.hasMany sql.models.yard
sql.models.yard.belongsTo sql.models.sunnyclient

sql.models.yard.belongsTo sql.models.geoposition,
  foreignKey: 'location_id'
  targetKey: 'id'

sql.models.yard.hasMany sql.models.yardroutine


#sql.models.yard.belongsTo sql.models.geoposition,
#  foreignKey: 'location_id'
#  targetKey: 'id'

sql.models.maplocation.belongsTo sql.models.geoposition

#sql.models.userconfig.sync
#  force: true
#sql.models.todo.sync
#  force: true
#sql.models.document.sync
#  force: true
#sql.models.yard.sync
#  force: true
#sql.models.geoposition.sync
#  force: true
#sql.models.sunnyclient.sync
#  force: true
#sql.models.maplocation.sync
#  force: true

# import legistar tables

lgrdir = path.join __dirname, 'lgrmodels'
# FIXME fix lgr_item_tags, ignored for now
ignored_tables = ['lgr_item_tags']
filtered = fs.readdirSync(lgrdir).filter (file) ->
  #console.log "DIRNAME", __dirname, file
  result = false
  if file.endsWith '.coffee'
    result = true
    if file.split('.coffee')[0] in ignored_tables
      console.log "ignoring", file
      result = false
  result

filtered.forEach (file) ->
  file = file.split('.coffee')[0]
  console.log "IMPORT", file
  sequelize.import path.join lgrdir, file
    

#fs.readdirSync(__dirname).filter((file) ->
#  file.indexOf('.') != 0 and file != 'index.js'
#).forEach (file) ->
#  model = sequelize.import(path.join(__dirname, file))
#  db[model.name] = model
#  return
#Object.keys(db).forEach (modelName) ->
#  if 'associate' of db[modelName]
#    db[modelName].associate db
#  return

# FIXME get this from config
#sequelize.models.user.findOrCreate
#  where:
#    name: 'admin'
#  defaults:
#    password: 'admin'
#    config:
#      theme: 'BlanchedAlmond'
#      foo: 'bar'
#      cat: 'dog'
#      
#.then (user, created) ->
#  return
  
  
db.sequelize = sequelize
db.Sequelize = Sequelize
module.exports = db
