fs = require 'fs'
path = require 'path'
Sequelize = require 'sequelize'

env = process.env.NODE_ENV or 'development'
config = require('../config')[env]

sequelize = new Sequelize(config.database, config.username, config.password, config)
db = {}

force_sync = (model) ->
  model.sync
    force: true

force_sync_models = (models) ->
  for model in models
    force_sync model
    
  

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

# import legistar models
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
console.log "===============ALL IMPORTED========================"


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


Meeting = sql.models.lgr_meetings
Item = sql.models.lgr_items

# http://stackoverflow.com/a/25072476
Meeting.belongsToMany Item,
  as: 'items'
  through:
    model: sql.models.lgr_meeting_item
  foreignKey: 'meeting_id'

Meeting.sync()

#console.log "setup first association?"
#console.log Object.keys Meeting.associations

Item.belongsToMany Meeting,
  as: 'meetings'
  through:
    model: sql.models.lgr_meeting_item
  foreignKey: 'item_id'

Attachment = sql.models.lgr_attachments
Item.hasMany Attachment,
  as: 'attachments'
  foreignKey: 'item_id'

Action = sql.models.lgr_actions
Item.belongsToMany Action,
  as: 'actions'
  through:
    model: sql.models.lgr_item_action
  foreignKey: 'item_id'

Action.belongsToMany Item,
  as: 'items'
  through:
    model: sql.models.lgr_item_action
  foreignKey: 'action_id'
  
Attachment.sync()
Item.sync()
#console.log "setup second association?"
#console.log Object.keys Item.associations

  
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

  
db.sequelize = sequelize
db.Sequelize = Sequelize
module.exports = db
