webpackJsonp([12],{55:function(t,e,r){var n,o,i,u,p,c,a,s,l,f,d,w,_=function(t,e){function r(){this.constructor=t}for(var n in e)y.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},y={}.hasOwnProperty;n=r(0),p=r(2),w=r(3),s=r(59),l=r(4).navigate_to_url,u=n.Radio.channel("global"),o=w.renderable(function(t){return w.article(".document-view.content",function(){return w.a(".btn.btn-default",{href:"#"},"Posts"),w.div(".body",function(){return w.raw(s(t.markdown))})})}),d=w.renderable(function(t){return w.div(".listview-list-entry",function(){return w.raw(s(t.markdown.slice(0,500)))})}),f=w.renderable(function(){return w.div(".listview-header","Articles"),w.div("#post-list.list-group")}),o=w.renderable(function(t){return w.article(".document-view.content",function(){return w.div(".body",function(){return w.raw(s(t.content))})})}),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return _(e,t),e.prototype.template=d,e.prototype.ui={item:".listview-list-entry"},e.prototype.events={"click @ui.item":"view_post"},e.prototype.view_post=function(t){var e;return e=this.model.get("slug"),l("#pages/"+e)},e}(n.Marionette.View),c=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return _(e,t),e.prototype.template=f,e.prototype.childView=a,e}(n.Marionette.CompositeView),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return _(e,t),e.prototype.template=o,e}(n.Marionette.View),t.exports={FrontDoorMainView:i,PostList:c}}});