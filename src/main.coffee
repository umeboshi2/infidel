os = require 'os'
path = require 'path'
http = require 'http'

express = require 'express'
gzipStatic = require 'connect-gzip-static'
# FIXME start using this
ensureLogin = require 'connect-ensure-login'

passport = require 'passport'

Middleware = require './middleware'
#UserAuth = require './userauth'
pages = require './pages'

webpackManifest = require '../build/manifest.json'

# Set the default environment to be `development`
# this needs to be set before booting ghost
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

UseMiddleware = false or process.env.__DEV_MIDDLEWARE__ is 'true'
PORT = process.env.NODE_PORT or 8081
HOST = process.env.NODE_IP or 'localhost'

# create express app 
app = express()

# FIXME
#kdb = require './kmodels'
kdb = require 'ghost/core/server/data/db'

# FIXME use express template render
#app.set "views", "./views"
#app.set 'view_engine', 'teacup/lib/express'
 
#app.configure ->
#  app.engine "coffee", tc.renderFile


setup_after_ghost = (ghost) ->

  passport = require 'passport'
  app.use passport.initialize()
  
  db = require './models'
  sql = db.sequelize

  Middleware.setup app
  
  ApiRoutes = require './apiroutes'
  ApiRoutes.setup app
  # FIXME
  # make a bearer strategy similar to ghost strategy

  
  # health url required for openshift
  app.get '/health', (req, res, next) ->
    res.end()

  app.use '/assets', express.static(path.join __dirname, '../assets')
  if UseMiddleware
    #require 'coffee-script/register'
    webpack = require 'webpack'
    middleware = require 'webpack-dev-middleware'
    config = require '../webpack.config'
    compiler = webpack config
    app.use middleware compiler,
      #publicPath: config.output.publicPath
      # FIXME using abosule path?
      publicPath: '/build/'
      stats:
        colors: true
    console.log "Using webpack middleware"
  else
    app.use '/build', gzipStatic(path.join __dirname, '../build')

  auth = (req, res, next) ->
    #console.log req
    if req.isAuthenticated()
      #console.log req
      next()
    else
      res.redirect '/#frontdoor/login'
    
  auth = require 'ghost/core/server/middleware/auth'
  console.log auth

  app.get '/', pages.make_page 'index'
  #app.get '/sunny', auth.requiresAuthorizedUser, pages.make_page 'sunny'
  app.get '/sunny', pages.make_page 'sunny'

  admin_auth = (req, res, next) ->
    if req.isAuthenticated() and req.user.name == 'admin'
      next()
    else
      res.sendStatus(403)
    
  app.get '/admin', auth.requiresAuthorizedUser, admin_auth, pages.make_page 'admin'

      


  server = http.createServer app
  sql.sync()
    .then ->
      server.listen PORT, HOST, -> 
        console.log "Infidel server running on #{HOST}:#{PORT}."


bootghost = require('./bootghost')

processBuffer = (buffer, app) ->
  while buffer.length
    request = buffer.pop()
    app request[0], request[1]
  return

#ghostServer = undefined

makeGhostMiddleware = (options) ->
  requestBuffer = []
  exapp = false
  bootghost.init(options).then (ghost) ->
    setup_after_ghost ghost
    exapp = ghost.rootApp
    #console.log "global.ghostServer", global.ghostServer
    console.log "bootghost.init"
    processBuffer requestBuffer, exapp
    return
  (req, res) ->
    if !exapp
      requestBuffer.unshift [
        req
        res
      ]
    else
      exapp req, res
    return

ghostOptions =
  config: path.join __dirname, '..', 'ghost-config.js'
ghost_middleware = makeGhostMiddleware ghostOptions
app.use '/blog', ghost_middleware

  
module.exports =
  app: app
  kdb: kdb
  
