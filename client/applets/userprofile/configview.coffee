Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

MainChannel = Backbone.Radio.channel 'global'

user_config_template = tc.renderable (model) ->
  tc.div '.form-group', ->
    tc.label '.control-label',
      for: 'select_doctype'
      "Theme"
    tc.select '.form-control', name:'select_doctype', ->
      for opt in ['cornsilk', 'BlanchedAlmond']
        if model.config.theme is opt
          tc.option selected:null, value:opt, opt
        else
          tc.option value:opt, opt

class UserConfigView extends Backbone.Marionette.ItemView
  template: user_config_template
  


module.exports = UserConfigView

