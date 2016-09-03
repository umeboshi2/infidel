Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
Leaflet = require 'leaflet'

require 'leaflet/dist/leaflet.css'

{ navigate_to_url } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'

default_mapview_style = 'height:20em;'
fs_mapview_style = 'position: absolute; top: 0; right: 0; bottom: 0; left: 0;'

map_view_template = tc.renderable (model) ->
  tc.div ->
    tc.h2 "Map View"
    tc.div '.checkbox', ->
      tc.label ->
        tc.input '#watch-map', type:'checkbox'
        tc.text 'watch'
    tc.div "#map-view", style: default_mapview_style
    
    
class MapView extends Backbone.Marionette.View
  template: map_view_template
  ui:
    map: '#map-view'
    watch: '#watch-map'
  events:
    'change @ui.watch': 'watch_button'
  defaultMapStyle: default_mapview_style
  fsMapStyle: fs_mapview_style
  first_location_error: false

  
  watch_button: (event) ->
    console.log 'somwthing happened', event
    if event.target.checked
      console.log "Watch me!!!!", @ui.map
      @Map.locate
        watch: true
    else
      console.log "Stop watching me....", @ui.map
      @Map.locate
        watch: false
      
    
    
  onDomRefresh: ->
    @Map = Leaflet.map 'map-view'
    zoom_level = 13
    location = [31.33, -89.28]
    #@Map.setView location, zoom_level
    @Map.on 'moveend', @getCenter
    @Map.on 'locationerror', @onLocationError
    @Map.locate
      setView: true
      watch: false
    layer = Leaflet.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png'
    layer.addTo @Map
    console.log "MAP, LAYER", @Map, layer
    circle = Leaflet.circle location, 200
    circle.addTo @Map
      
  getCenter: (event) =>
    console.log @Map.getCenter()

  onLocationError: (event) =>
    console.log "unable to get location", event
    if not @first_location_error
      console.log 'initialize map location'
      location = [31.33, -89.28]
      @Map.setView location, 13
      @first_location_error = true
      
module.exports = MapView

