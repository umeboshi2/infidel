ghost_config = require '../ghost-config'

module.exports =
  development:
    apipath: '/api/dev'
    dialect: 'sqlite'
    #storage: "#{ghost_config.development.database.connection.filename}-extra"
    storage: ghost_config.development.database.connection.filename
    omitNull: true
    logging: console.log
  production:
    apipath: '/api/dev'
    dialect: 'sqlite'
    #storage: "#{ghost_config.production.database.connection.filename}-extra"
    storage: ghost_config.production.database.connection.filename
    omitNull: true
