Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

MainChannel = Backbone.Radio.channel 'global'

user_profile_template = tc.renderable (model) ->
  tc.div ->
    tc.span "User Name: #{model.name}"
    tc.br()
    tc.span "Config: #{model.config}"
    tc.br()
    tc.a href:"#profile/editconfig", 'Edit Config'
    
class UserMainView extends Backbone.Marionette.ItemView
  template: user_profile_template
  


module.exports = UserMainView

