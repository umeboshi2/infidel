webpackJsonp([15],{tyl1:function(t,r,n){var e,i,o,a,d,p,u,s,c=function(t,r){function n(){this.constructor=t}for(var e in r)y.call(r,e)&&(t[e]=r[e]);return n.prototype=r.prototype,t.prototype=new n,t.__super__=r.prototype,t},y={}.hasOwnProperty;e=n("aGLy"),a=n("y11e"),s=n("2mEY"),u=n("SiQm").navigate_to_url,p=s.renderable(function(t){return s.div(".row.listview-list-entry",function(){return s.a({href:"#sunny/yards/view/"+t.id},t.name)})}),d=s.renderable(function(t){return s.div(".row.listview-list-entry",function(){return s.span("Name: "+t.name),s.br(),s.span("Full Name: "+t.fullname),s.br(),s.span("Email: "+t.email),s.br(),s.span("Description"),s.br(),s.div(t.description),s.span(".glyphicon.glyphicon-grain")}),s.div(".row",function(){return s.div(".listview-header",function(){return s.span("Yards"),s.button("#add-yard-btn.btn.btn-default.btn-xs.pull-right","Add Yard")})}),s.div(".row",function(){return s.div("#client-yards")})}),o=function(t){function r(){return r.__super__.constructor.apply(this,arguments)}return c(r,t),r.prototype.template=p,r}(e.Marionette.View),i=function(t){function r(){return r.__super__.constructor.apply(this,arguments)}return c(r,t),r.prototype.childView=o,r.prototype.childViewContainer="#client-yards",r.prototype.template=d,r.prototype.ui={addyard:"#add-yard-btn",yards:"#client-yards"},r.prototype.events=function(){return{"click @ui.addyard":"add_yard"}},r.prototype.add_yard=function(){return u("#sunny/yards/add/"+this.model.id)},r}(e.Marionette.CompositeView),t.exports=i}});