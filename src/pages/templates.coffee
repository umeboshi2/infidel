tc = require 'teacup'

base_page = tc.renderable (appfile, manifest, theme, clients) ->
  tc.doctype()
  tc.html xmlns:'http://www.w3.org/1999/xhtml', ->
    tc.head ->
      tc.meta charset:'utf-8'
      tc.meta name:'viewport', content:"width=device-width, initial-scale=1"
      tc.meta name:'client-id', value:'ghost-admin'
      tc.meta name:'client-secret', value:clients['ghost-admin']
      tc.link rel:'stylesheet', type:'text/css',
      href:"assets/stylesheets/font-awesome.css"
      tc.link rel:'stylesheet', type:'text/css',
      href:"assets/stylesheets/bootstrap-#{theme}.css"
    tc.body ->
      tc.div '.container-fluid', ->
        tc.div '.row', ->
          tc.div '.col-sm-2'
          tc.div '.col-sm-6.jumbotron', ->
            tc.h1 ->
              tc.text 'Loading ...'
              tc.i '.fa.fa-spinner.fa-spin'
          tc.div '.col-sm-2'
      tc.script
        type: 'text/javascript'
        charset: 'utf-8'
        src: "build/#{manifest['vendor.js']}"
      tc.script
        type: 'text/javascript'
        charset: 'utf-8'
        src: "build/#{manifest['agate.js']}"
      tc.script
        type: 'text/javascript'
        charset: 'utf-8'
        src: "build/#{manifest[appfile]}"
              

index = (manifest, theme, clients) ->
  base_page 'index.js', manifest, theme, clients
sunny = (manifest, theme, clients) ->
  base_page 'sunny.js', manifest, theme, clients
admin = (manifest, theme, clients) ->
  base_page 'admin.js', manifest, theme, clients
  
module.exports =
  index: index
  sunny: sunny
  admin: admin
  
  
