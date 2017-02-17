Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
marked = require 'marked'
{ navigate_to_url } = require 'agate/src/apputil'

MainChannel = Backbone.Radio.channel 'global'

DefaultStaticDocumentTemplate = tc.renderable (post) ->
  tc.article '.document-view.content', ->
    tc.a '.btn.btn-default', href:"#", "Posts"
    tc.div '.body', ->
      tc.raw marked post.markdown

post_list_item = tc.renderable (post) ->
  tc.div '.listview-list-entry', ->
    tc.raw marked post.markdown.slice 0, 500
    
post_list = tc.renderable ->
  tc.div '.listview-header', 'Articles'
  tc.div '#post-list.list-group'

DefaultStaticDocumentTemplate = tc.renderable (doc) ->
  #atts = doc.data.attributes
  tc.article '.document-view.content', ->
    tc.div '.body', ->
      tc.raw marked doc.content

class PostListItem extends Backbone.Marionette.View
  template: post_list_item
  ui:
    item: '.listview-list-entry'
  events:
    'click @ui.item': 'view_post'

  view_post: (event) ->
    slug = @model.get 'slug'
    navigate_to_url "#pages/#{slug}"
    
class PostList extends Backbone.Marionette.CompositeView
  template: post_list
  childView: PostListItem
  
class FrontDoorMainView extends Backbone.Marionette.View
  template: DefaultStaticDocumentTemplate

module.exports =
  FrontDoorMainView: FrontDoorMainView
  PostList: PostList
  
