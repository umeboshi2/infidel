Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
Leaflet = require 'leaflet'

require 'leaflet/dist/leaflet.css'

{ navigate_to_url } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'
SunnyChannel = Backbone.Radio.channel 'sunny'

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
    


# taken from Leaflet.Icon.Glyph
# Base64-encoded version of glyph-marker-icon.png
iconUrl = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAApCAYAAADAk4LOAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAN1wAADdcBQiibeAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAUlSURBVFjDrZdLiBxVFIb/e289uqt6kkx6zIiIoKgLRReKuMhCcaOIAUEIiCCE4CIPggZ8kBjooPgM0TiYEUUjqBGchZqAQlyYRTA+kJiJQiJGMjN5zYzT3dP1rrr3HBeTjDGTSfc8Dvyruud89Z9z6kIJdBj31763MivsJXKuZYF6dak5++2mh7NOcsXVHq6sHbhOK/24kOJJMO4AE1vKygwZhxlKSHGKiD+RSu09vOXB43OCrHz96y6T2lsh+OmKXzFdlbLne2UopSAupBhjECcZgjDMgiiSxPhcK/nCr1sfOtcWcm/tq9uEsL4rl0vdK67pKVu2jUwTMk0wBBAzpBCQAnAtiZIlwWQwPlHPglZQAFj1Y23VwVkh92zbd59U+Kanp+p2L12mooKQ5AbcpuclS6LiKoRhxOfHzhXMcs3PtVV7Z0DufXH/LSzpSG9vr1/p6kIz0dDUrvx/IYXAsrJCkWc4e/Z0Zpgf+KX26A/TkNtrXziesY9Xq8tvWNZdVfVYg7hzwKVv3O3ZiKMWj46OTrq5fdOh1x5pSADwjdzo2nbv0u6qqkca2jCIMGcZAuqRhu8vEX7ZK2V2WgMAcXdtvyeKbPS662+osCohzMycHVweniNREoShoZO5KYobpciSh23bFq7rIUgNiLFghRkBlg2v7GlpiccsCHrcryzxUk3zmsNskeYGvt/lxVH4hMWEu9xSWaQFYQ7L1B6iGZ5bBoy+zWKiHiltFHpqeIsVhWaosg1iqlgg4wAAEYEXsV3EmNppJmExMFYUxfVSuIs6E0sI5FkBBhLJzH9laQxLSjBj0WQJgSJPweDTkknvS4JGbCuxKOt7UY4lEQfNnAu9TzLxN2nUdAQTLAEw8YIlAVgAkmDCSBL75eCutSeY+GTUqqNkqUVxUbIl4qgJo4vWzecrhyQAMJldYf1MXLLl1EIsYBZgoGwpRI2zMTPtGBhYbSQAlJF9lieRzNMIriVBzPOWawvoIkYaNC0u9IcAIAHgp75NLQl8ENbPZJ6jgAU48RyFqHEuZyE+Pda/vjENAQBD5s209Y+kPJlyM4+r3lUS0AWSyVEhpHnjYu1pyO+7N4ywwPvhxHDiuwo8j1b5rkQwMZIziYHBXetPzIAAgIV8exZOSMoieI6aU5vKtgR0jqw1JtiYbZfW/R/kSN+mcWbxdtwYjn1XTd9B7cQAfNdCWB/OhBR7jvWv/3tWCAAoO3ktjyZZJ0HHbsq2AooERVQXzPKly2vOgPz29jNNBr+e1IcSz5YAM4hmFzPDtyWS+lDK4N2DfU+dbgsBAFHyd+oszE3agt/GjWcrUBEjj5sQBb96pXpXhAzueDJi4u1p41TsuQpCiFln4bkKeXMoJeadg++tG+sYAgBBXOo3RRrruAnfkWDmGfIdCeQhiiQgQbxjtlqzQk59vCZlNluL5lDiORLyMjcA4DsKeXM4AfDKxa97ThAAqPaMfaR1Nq6jOiqOAhOm5TsKJg1QZGGRedY7V6tzVcjBWk1D0JZ8cigt2RJSimkXnqOgW8MxQLUTb6wN5g0BgGPV0c9BekTH41xx5YXrQ8FkTRgdpxU7ea9djbYQ1GokmJ43wUhWtgRcS04tQjAcw9CWw29tThYOAXD03XVfMps/TTTOy30blDZgiqxFK6p7OsnvCDJ1UD9LyUjORoPDkUQyPfdHbXW+qJCjfRsOwOAoNY4z6Xz01rHq3k5zO4ZMHTabYSIhJD87MLB64f8Ys8WdG/tfBljMJedfwY+s/2P4Pv8AAAAASUVORK5CYII='

# FIXME - subclass Leaflet.Icon for font-awesome/glyphicons
# using Leaflet.Icon.Glyph as example
myicon = Leaflet.icon
  iconUrl: iconUrl
  
  
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
      
    
  addYardMarkers: ->
    null
    
    
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
    yards = SunnyChannel.request 'yard-collection'
    response = yards.fetch()
    response.done =>
      for model in yards.models
        atts = model.attributes
        if atts.latitude 
          loc = [atts.latitude, atts.longitude]
          marker = Leaflet.marker loc,
            icon: myicon
            url: "#sunny/yards/view/#{atts.id}"
          console.log "marker location", loc, atts.id
          marker.addTo @Map
      
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

