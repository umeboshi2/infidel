webpackJsonp([5],{0:function(e,o,n){var t,r,a,i,u,p,s,c,l;l=n(33).start_with_user,i=n(3),c=n(25),t=n(32),console.log("APPMODEL",t),t.set("applets",[{name:"User Admin",url:"#useradmin"},{appname:"bumblr",name:"Bumblr",url:"#bumblr"},{appname:"phaserdemo",name:"Phaser",url:"#phaserdemo"}]),s=t.get("brand"),s.name="Admin Page",s.url="/",t.set({brand:s}),a=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),r=Backbone.Radio.channel("static-documents"),a.reply("main:app:appmodel",function(){return t}),n(35),n(31),n(30),p=new i.Application,c(p,t),l(p),e.exports=p},34:function(e,o,n){var t,r,a,i,u,p,s,c,l=function(e,o){function n(){this.constructor=e}for(var t in o)f.call(o,t)&&(e[t]=o[t]);return n.prototype=o.prototype,e.prototype=new n,e.__super__=o.prototype,e},f={}.hasOwnProperty;t=n(2),p=n(3),u=n(13).MainController,c=n(20).login_form,i=t.Radio.channel("global"),s=t.Radio.channel("messages"),a=t.Radio.channel("static-documents"),r=function(e){function o(){return o.__super__.constructor.apply(this,arguments)}return l(o,e),o.prototype._view_resource=function(e){return n.e(0,function(o){return function(){var t,r;return t=n(104).FrontDoorMainView,r=new t({model:e}),o._show_content(r)}}(this))},o.prototype.view_page=function(e){var o,n;return o=a.request("get-document",e),n=o.fetch(),n.done(function(e){return function(){return e._view_resource(o)}}(this)),n.fail(function(e){return function(){return s.request("danger","Failed to get document")}}(this))},o.prototype.frontdoor_needuser=function(){var e;return e=i.request("current-user"),e.has("name")?this.frontdoor_hasuser(e):this.show_login()},o.prototype.show_login=function(){var e;return e=new t.Marionette.ItemView({template:c}),this._show_content(e)},o.prototype.frontdoor_hasuser=function(e){return this.default_view()},o.prototype.default_view=function(){return this.view_page("intro")},o.prototype.frontdoor=function(){var e;return e=i.request("main:app:appmodel"),e.get("needUser")?(console.log("needUser is true"),this.frontdoor_needuser()):this.view_page("intro")},o}(u),e.exports=r},35:function(e,o,n){var t,r,a,i,u=function(e,o){function n(){this.constructor=e}for(var t in o)p.call(o,t)&&(e[t]=o[t]);return n.prototype=o.prototype,e.prototype=new n,e.__super__=o.prototype,e},p={}.hasOwnProperty;t=n(12),r=n(34),a=Backbone.Radio.channel("global"),i=function(e){function o(){return o.__super__.constructor.apply(this,arguments)}return u(o,e),o.prototype.empty_sidebar_on_route=!0,o.prototype.appRoutes={"":"frontdoor",frontdoor:"frontdoor","frontdoor/view":"frontdoor","frontdoor/view/:name":"view_page","frontdoor/login":"show_login","pages/:name":"view_page"},o}(t),a.reply("applet:frontdoor:route",function(){var e,o;return e=new r(a),o=new i({controller:e})})}});