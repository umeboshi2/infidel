beautify = require('js-beautify').html

pages = require './templates'
webpackManifest = require '../../build/manifest.json'

kdb = require '../kmodels'

# FIXME require this  
UseMiddleware = false or process.env.__DEV_MIDDLEWARE__ is 'true'

get_manifest = (name) ->
  if UseMiddleware
    manifest =
      'vendor.js': 'vendor.js'
      'agate.js': 'agate.js'
    filename = "#{name}.js"
    manifest[filename] = filename
  else
    manifest = webpackManifest
  return manifest


client_secret_query = ->
  kdb.knex.table('clients').select('slug', 'secret')
    
handle_client_rows = (rows) ->
  clients = {}
  for row in rows
    clients[row.slug] = row.secret
  clients
  
create_page_html = (name, manifest, theme, clients) ->
  page = pages[name] manifest, theme, clients
  beautify page

make_page_header = (res, page) ->
  res.writeHead 200,
    'Content-Length': Buffer.byteLength page
    'Content-Type': 'text/html'
  
write_page = (page, res, next) ->
  make_page_header res, page
  res.write page
  res.end()
  next()      

make_page = (name) ->
  (req, res, next) ->
    # FIXME make a site config
    theme = 'cornsilk'
    console.log 'req.user', req.user
    # FIXME: use passport bearer
    # stratedgy to get user object
    # on requests
    #if req.isAuthenticated()
    #  config = req.user.config
    #  theme = config.theme
    client_secret_query()
    .then handle_client_rows
    .then (clients) ->
      console.log "clients", clients
      manifest = get_manifest name
      page = create_page_html name, manifest, theme, clients
      write_page page, res, next
  
module.exports =
  make_page: make_page
  client_secret_query: client_secret_query
