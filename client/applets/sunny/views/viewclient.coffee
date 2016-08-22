Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'

{ navigate_to_url } = require 'agate/src/apputil'

client_yard_teplate = tc.renderable (model) ->
  tc.div '.row.listview-list-entry', ->
    tc.span model.name
    
client_view_template = tc.renderable (model) ->
  tc.div '.row.listview-list-entry', ->
    tc.span "Name: #{model.name}"
    tc.br()
    tc.span "Full Name: #{model.fullname}"
    tc.br()
    tc.span "Description"
    tc.br()
    tc.div model.description
    tc.span ".glyphicon.glyphicon-grain"
  tc.div '.row', ->
    tc.div '.listview-header', ->
      tc.span 'Yards'
      tc.button '#add-yard-btn.btn.btn-default.btn-xs.pull-right', 'Add Yard'
  tc.div '.row', ->
    tc.div "#client-yards"


class ClientYardView extends Backbone.Marionette.ItemView
  template: client_yard_teplate
  
class ClientMainView extends Backbone.Marionette.CompositeView
  childView: ClientYardView
  template: client_view_template
  ui:
    addyard: '#add-yard-btn'
    yards: '#client-yards'
  events: ->
    'click @ui.addyard': 'add_yard'

  add_yard: ->
    navigate_to_url "#sunny/clients/addyard/#{@model.id}"
    
module.exports = ClientMainView

