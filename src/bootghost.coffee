# # Bootup
# This file needs serious love & refactoring
# Module dependencies
express = require 'express'
_ = require 'lodash'
uuid = require 'node-uuid'
Promise = require 'bluebird'
i18n = require 'ghost/core/server/i18n'
api = require 'ghost/core/server/api'
config = require 'ghost/core/server/config'
errors = require 'ghost/core/server/errors'
middleware = require 'ghost/core/server/middleware'
migrations = require 'ghost/core/server/data/migration'
versioning = require 'ghost/core/server/data/schema/versioning'
models = require 'ghost/core/server/models'
permissions = require 'ghost/core/server/permissions'
apps = require 'ghost/core/server/apps'
sitemap = require 'ghost/core/server/data/xml/sitemap'
xmlrpc = require 'ghost/core/server/data/xml/xmlrpc'
slack = require 'ghost/core/server/data/slack'
GhostServer = require 'ghost/core/server/ghost-server'
scheduling = require 'ghost/core/server/scheduling'
validateThemes = require 'ghost/core/server/utils/validate-themes'
dbHash = undefined



initDbHashAndFirstRun = ->
  api.settings.read(
    key: 'dbHash'
    context: internal: true).then (response) ->
    hash = response.settings[0].value
    initHash = undefined
    dbHash = hash
    if dbHash == null
      initHash = uuid.v4()
      return api.settings.edit({ settings: [ {
        key: 'dbHash'
        value: initHash
      } ] }, context: internal: true).then((response) ->
        dbHash = response.settings[0].value
        dbHash
        # Use `then` here to do 'first run' actions
      )
    dbHash

# ## Initialise Ghost
# Sets up the express server instances, runs init on a bunch of stuff, configures views, helpers, routes and more
# Finally it returns an instance of GhostServer

init = (options) ->
  options = options or {}
  ghostServer = null
  # ### Initialisation
  # The server and its dependencies require a populated config
  # It returns a promise that is resolved when the application
  # has finished starting up.
  # Initialize Internationalization
  i18n.init()
  # Load our config.js file from the local file system.
  config.load(options.config).then(->
    config.checkDeprecated()
  ).then(->
    models.init()
    return
  ).then(->
    versioning.getDatabaseVersion().then((currentVersion) ->
      response = migrations.update.isDatabaseOutOfDate(
        fromVersion: currentVersion
        toVersion: versioning.getNewestDatabaseVersion()
        forceMigration: process.env.FORCE_MIGRATION)
      maintenanceState = undefined
      if response.migrate == true
        maintenanceState = config.maintenance.enabled or false
        config.maintenance.enabled = true
        migrations.update.execute(
          fromVersion: currentVersion
          toVersion: versioning.getNewestDatabaseVersion()
          forceMigration: process.env.FORCE_MIGRATION).then(->
          config.maintenance.enabled = maintenanceState
          return
        ).catch (err) ->
          errors.logErrorAndExit err, err.context, err.help
          return
      else if response.error
        return Promise.reject(response.error)
      return
    ).catch (err) ->
      if err instanceof errors.DatabaseNotPopulated
        return migrations.populate()
      Promise.reject err
  ).then(->
    # Populate any missing default settings
    models.Settings.populateDefaults()
  ).then(->
    # Initialize the settings cache
    api.init()
  ).then(->
    # Initialize the permissions actions and objects
    # NOTE: Must be done before initDbHashAndFirstRun calls
    permissions.init()
  ).then(->
    Promise.join initDbHashAndFirstRun(), apps.init(), sitemap.init(), xmlrpc.listen(), slack.listen()
  ).then(->
    # Get reference to an express app instance.
    parentApp = express()
    # ## Middleware and Routing
    middleware parentApp
    # Log all theme errors and warnings
    validateThemes(config.paths.themePath).catch (result) ->
      # TODO: change `result` to something better
      result.errors.forEach (err) ->
        errors.logError err.message, err.context, err.help
        return
      result.warnings.forEach (warn) ->
        errors.logWarn warn.message, warn.context, warn.help
        return
      return
    new GhostServer(parentApp)
  ).then((_ghostServer) ->
    ghostServer = _ghostServer
    # scheduling can trigger api requests, that's why we initialize the module after the ghost server creation
    # scheduling module can create x schedulers with different adapters
    scheduling.init _.extend(config.scheduling, apiUrl: config.url + config.urlFor('api'))
  ).then ->
    ghostServer

module.exports =
  init: init
  models: models
  api: api
  
