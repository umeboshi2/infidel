os = require 'os'
path = require 'path'
http = require 'http'

express = require 'express'
gzipStatic = require 'connect-gzip-static'
# FIXME start using this
ensureLogin = require 'connect-ensure-login'

passport = require 'passport'
ClientPasswordStrategy  = require('passport-oauth2-client-password').Strategy
BearerStrategy = require('passport-http-bearer').Strategy

Middleware = require './middleware'
#UserAuth = require './userauth'
pages = require './pages'

webpackManifest = require '../build/manifest.json'

UseMiddleware = false or process.env.__DEV_MIDDLEWARE__ is 'true'
PORT = process.env.NODE_PORT or 8081
HOST = process.env.NODE_IP or 'localhost'

# create express app 
app = express()

ghost = require './ghost-middleware'
ghostOptions =
  config: path.join __dirname, '..', 'ghost-config.js'

ghost_middleware = ghost ghostOptions
console.log "ghost_middleware", ghost_middleware
app.use '/blog', ghost_middleware
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
  if req.isAuthenticated()
    console.log req
    next()
  else
    res.redirect '/#frontdoor/login'
    

app.get '/', pages.make_page 'index'
app.get '/sunny', auth, pages.make_page 'sunny'

admin_auth = (req, res, next) ->
  if req.isAuthenticated() and req.user.name == 'admin'
    next()
  else
    res.sendStatus(403)
    
app.get '/admin', auth, admin_auth, pages.make_page 'admin'

      


server = http.createServer app
sql.sync()
  .then ->
    server.listen PORT, HOST, -> 
      console.log "Server running on #{HOST}:#{PORT}."
  
module.exports =
  app: app
  ghost: ghost
  server: server
  
#sql.sync()
#.then ->
#  ghost ghostOptions
#  .then (ghostServer) ->
#    app.use ghostServer.config.paths.subdir, ghostServer.rootApp
#    ghostServer.start app
#    .then ->
#      server = http.createServer app
#      server.listen PORT, HOST, -> 
#      console.log "Server running on #{HOST}:#{PORT}."
  
