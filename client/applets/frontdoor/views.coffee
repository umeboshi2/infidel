Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
marked = require 'marked'

MainChannel = Backbone.Radio.channel 'global'

DefaultStaticDocumentTemplate = tc.renderable (post) ->
  tc.article '.document-view.content', ->
    tc.a '.btn.btn-default', href:"#", "Posts"
    tc.div '.body', ->
      tc.raw marked post.markdown

post_list_item = tc.renderable (post) ->
  tc.div '.listview-list-entry', ->
    #tc.a href:"#pages/#{post.slug}", post.title
    tc.a '.btn.btn-default', href:"#pages/#{post.slug}", "View"
    tc.raw marked post.markdown.slice 0, 500
    
post_list = tc.renderable ->
  tc.div '.listview-header', 'Articles'
  tc.div '#post-list.list-group'


class PostListItem extends Backbone.Marionette.ItemView
  template: post_list_item

class PostList extends Backbone.Marionette.CompositeView
  template: post_list
  childView: PostListItem
  
class FrontDoorMainView extends Backbone.Marionette.ItemView
  template: DefaultStaticDocumentTemplate

module.exports =
  FrontDoorMainView: FrontDoorMainView
  PostList: PostList
  
