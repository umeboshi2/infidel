Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

tc = require 'teacup'


{ remove_trailing_slashes
  make_json_post
  random_choice } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'
GoogleApiKey = 'GoogleApiKey'



########################################
# Templates
########################################
template = tc.renderable (model) ->
  tc.span 'please help me'
  tc.script async:'' defer:'', src:"https://maps.googleapis.com/maps/api/js?key=#{GoogleApiKey}"
  
########################################
  

class ParchmentView extends Backbone.Marionette.ItemView
  template: template

  onDomRefresh: ->
    console.log "onDomRefresh"
    
  
module.exports = ParchmentView

