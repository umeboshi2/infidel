webpackJsonp([4],{0:function(t,n,o){var e,r,i,u,c,p,a,s,l,_,d,f;d=o(52).start_with_user,u=o(3),_=o(27),e=o(51),s=[{appname:"sunny",name:"Sunny",url:"#sunny"},{appname:"bumblr",name:"Bumblr",url:"#bumblr"},{appname:"todos",name:"Todos",url:"#todos"},{appname:"userprofile",name:"Profile Page",url:"#profile"},{appname:"dbdocs",name:"DB Docs",url:"#dbdocs"},{appname:"mappy",name:"Map",url:"#mappy"}],e.set("applets",s),l=e.get("brand"),l.url="#",e.set({brand:l}),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("messages"),r=Backbone.Radio.channel("static-documents"),f={label:"Sunny",applets:["sunny","todos","dbdocs"],single_applet:!1},a=[f,{label:"Blog",single_applet:!1,url:"/blog"},{label:"Stuff",single_applet:!1,applets:["mappy","bumblr","userprofile"]}],e.set("applet_menus",a),i.reply("main:app:appmodel",function(){return e}),o(43),o(50),o(38),o(141),o(46),o(41),o(49),p=_(e),d(p),t.exports=p},39:function(t,n,o){var e,r,i,u,c,p=function(t,n){function o(){this.constructor=t}for(var e in n)a.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},a={}.hasOwnProperty;i=o(11).MainController,r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),c=Backbone.Radio.channel("resources"),e=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.collection=c.request("document-collection"),n.prototype.list_pages=function(){return this.setup_layout_if_needed(),console.log("List Pages"),o.e(0,function(t){return function(){var n,e,r;return n=o(116),r=new n({collection:t.collection}),e=t.collection.fetch(),e.done(function(){return t._show_content(r)}),e.fail(function(){return u.request("danger","Failed to load documents.")})}}(this))},n.prototype.edit_page=function(t){return this.setup_layout_if_needed(),o.e(1,function(n){return function(){var e,r;return e=o(32).EditPageView,r=c.request("get-document",t),n._load_view(e,r)}}(this))},n.prototype.new_page=function(){return this.setup_layout_if_needed(),o.e(1,function(t){return function(){var n;return n=o(32).NewPageView,t._show_content(new n)}}(this))},n}(i),t.exports=e},40:function(t,n,o){var e,r,i,u,c,p,a,s,l,_=function(t,n){function o(){this.constructor=t}for(var e in n)d.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},d={}.hasOwnProperty;e=o(2),l=o(14),c=l.GhostModel,u=l.GhostCollection,s=o(15).make_dbchannel,p=e.Radio.channel("resources"),a="/api/dev/sitedocuments",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.urlRoot=a,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.url=a,n.prototype.model=r,n}(u),s(p,"document",r,i),t.exports={DocumentCollection:i}},41:function(t,n,o){var e,r,i,u,c,p=function(t,n){function o(){this.constructor=t}for(var e in n)a.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},a={}.hasOwnProperty;e=o(10),o(40),r=o(39),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("resources"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.appRoutes={dbdocs:"list_pages","dbdocs/documents/new":"new_page","dbdocs/documents/edit/:id":"edit_page"},n}(e),i.reply("applet:dbdocs:route",function(){var t,n;return t=new r(i),n=new c({controller:t})})},42:function(t,n,o){var e,r,i,u,c,p,a,s,l,_,d,f=function(t,n){function o(){this.constructor=t}for(var e in n)y.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},y={}.hasOwnProperty;e=o(2),p=o(3),c=o(11).MainController,_=o(23).login_form,s=o(16).SlideDownRegion,u=e.Radio.channel("global"),a=e.Radio.channel("messages"),d=o(4),l=d.renderable(function(){return d.div("#main-content.col-sm-12")}),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.template=l,n.prototype.regions=function(){return{content:new s({el:"#main-content",speed:"slow"})}},n}(e.Marionette.View),r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.layoutClass=i,n.prototype._view_resource=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r;return e=o(33).FrontDoorMainView,r=new e({model:t}),n.layout.showChildView("content",r)}}(this))},n.prototype._view_login=function(){return o.e(0,function(t){return function(){var n,e;return n=o(117),e=new n,t.layout.showChildView("content",e)}}(this))},n.prototype.view_page=function(t){var n,o;return n=u.request("main:ghost:posts"),o=u.request("main:ghost:get-post",t),o.done(function(o){return function(){var e;return e=n.find({slug:t}),o._view_resource(e)}}(this)),o.fail(function(t){return function(){return a.request("danger","Failed to get document")}}(this))},n.prototype.frontdoor_needuser=function(){var t;return t=u.request("current-user"),t.has("name")?this.frontdoor_hasuser(t):this.show_login()},n.prototype.show_login=function(){return this._view_login()},n.prototype.frontdoor_hasuser=function(t){return this.default_view()},n.prototype.default_view=function(){return this.setup_layout_if_needed(),o.e(0,function(t){return function(){var n,e,r;return n=o(33).PostList,e=u.request("main:ghost:posts"),r=e.fetch(),r.done(function(){var o;return o=new n({collection:e}),t.layout.showChildView("content",o)})}}(this))},n.prototype.frontdoor=function(){var t;return t=u.request("main:app:appmodel"),t.get("needUser")?(console.log("needUser is true"),this.frontdoor_needuser()):this.default_view()},n}(c),t.exports=r},43:function(t,n,o){var e,r,i,u,c=function(t,n){function o(){this.constructor=t}for(var e in n)p.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},p={}.hasOwnProperty;e=o(10),r=o(42),i=Backbone.Radio.channel("global"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return c(n,t),n.prototype.appRoutes={"":"frontdoor",frontdoor:"frontdoor","frontdoor/view":"frontdoor","frontdoor/view/:name":"view_page","frontdoor/login":"show_login","pages/:name":"view_page"},n}(e),i.reply("applet:frontdoor:route",function(){var t,n;return t=new r(i),n=new u({controller:t})})},44:function(t,n,o){var e,r,i,u,c,p,a=function(t,n){function o(){this.constructor=t}for(var e in n)s.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},s={}.hasOwnProperty;p=o(5),i=o(11).MainController,r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),c=Backbone.Radio.channel("sunny"),e=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.clients=c.request("client-collection"),n.prototype.list_clients=function(){return this.setup_layout_if_needed(),o.e(0,function(t){return function(){var n,e,r;return n=o(118),r=new n({collection:t.clients}),e=t.clients.fetch(),e.done(function(){return t._show_content(r)}),e.fail(function(){return u.request("danger","Failed to load clients.")})}}(this))},n.prototype.new_client=function(){return this.setup_layout_if_needed(),o.e(0,function(t){return function(){var n;return n=o(34).NewClientView,t.layout.showChildView("content",new n)}}(this))},n.prototype.add_yard=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r;return e=o(35).NewYardView,r=new e,r.sunnyclient_id=t,n.layout.showChildView("content",r)}}(this))},n.prototype.view_yard=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r,i;return e=o(35).EditYardView,r=c.request("get-yard",t),r.has("name")?n._show_edit_client(e,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(e,r)}),i.fail(function(){return u.request("danger","Failed to load yard data.")}))}}(this))},n.prototype._show_edit_client=function(t,n){var o;return o=new t({model:n}),this.layout.showChildView("content",o)},n.prototype.edit_client=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r,i;return e=o(34).EditClientView,r=c.request("get-client",t),r.has("name")?n._show_edit_client(e,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(e,r)}),i.fail(function(){return u.request("danger","Failed to load client data.")}))}}(this))},n.prototype._fetch_yards_and_view_client=function(t,n){var o,e;return o=c.request("yard-collection"),e=o.fetch({data:{sunnyclient_id:t.id}}),e.done(function(e){return function(){var r;return r=new n({model:t,collection:o}),window.cview=r,e.layout.showChildView("content",r)}}(this)),e.fail(function(t){return function(){return u.request("danger","Failed to load yards.")}}(this))},n.prototype.view_client=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r,i;return e=o(119),r=c.request("get-client",t),r.has("name")?n._fetch_yards_and_view_client(r,e):(i=r.fetch(),i.done(function(){return n._fetch_yards_and_view_client(r,e)}),i.fail(function(){return u.request("danger","Failed to load client data.")}))}}(this))},n}(i),t.exports=e},45:function(t,n,o){var e,r,i,u,c,p,a,s,l,_,d,f,y=function(t,n){function o(){this.constructor=t}for(var e in n)h.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},h={}.hasOwnProperty;e=o(2),_=o(15).make_dbchannel,d=o(14),c=d.GhostModel,u=d.GhostCollection,p=e.Radio.channel("global"),a=e.Radio.channel("sunny"),f="/api/dev/sunny/clients",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.urlRoot=f,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.model=r,n.prototype.url=f,n}(u),_(a,"client",r,i),f="/api/dev/sunny/yards",s=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.urlRoot=f,n}(c),l=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.model=s,n.prototype.url=f,n}(u),_(a,"yard",s,l),t.exports={ClientCollection:i,YardCollection:l}},46:function(t,n,o){var e,r,i,u,c,p=function(t,n){function o(){this.constructor=t}for(var e in n)a.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},a={}.hasOwnProperty;e=o(10),o(45),r=o(44),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("sunny"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.appRoutes={sunny:"list_clients","sunny/clients":"list_clients","sunny/clients/new":"new_client","sunny/clients/edit/:id":"edit_client","sunny/clients/view/:id":"view_client","sunny/clients/addyard/:client_id":"add_yard","sunny/yards/view/:id":"view_yard"},n}(e),i.reply("applet:sunny:route",function(){var t,n;t=new r(i),c.reply("main-controller",function(){return t}),c.reply("edit-client",function(n){return t.edit_client(n)}),n=new u({controller:t})})},47:function(t,n,o){var e,r,i,u,c,p,a=function(t,n){function o(){this.constructor=t}for(var e in n)s.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},s={}.hasOwnProperty;p=o(5),i=o(11).MainController,r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),c=Backbone.Radio.channel("todos"),e=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.collection=c.request("todo-collection"),n.prototype.list_todos=function(){return this.setup_layout_if_needed(),o.e(0,function(t){return function(){var n,e,r;return n=o(120),r=new n({collection:t.collection}),e=t.collection.fetch(),e.done(function(){return t._show_content(r)}),e.fail(function(){return u.request("danger","Failed to load todos.")})}}(this))},n.prototype.new_todo=function(){return this.setup_layout_if_needed(),o.e(0,function(t){return function(){var n;return n=o(36).NewView,t._show_content(new n)}}(this))},n.prototype.edit_todo=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r;return e=o(36).EditView,r=c.request("get-todo",t),n._load_view(e,r,"todo")}}(this))},n.prototype.view_todo=function(t){return this.setup_layout_if_needed(),o.e(0,function(n){return function(){var e,r;return e=o(121),r=c.request("get-todo",t),n._load_view(e,r,"todo")}}(this))},n}(i),t.exports=e},48:function(t,n,o){var e,r,i,u,c,p,a,s,l,_,d,f=function(t,n){function o(){this.constructor=t}for(var e in n)y.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},y={}.hasOwnProperty;e=o(2),l=o(14),u=l.GhostModel,i=l.GhostCollection,r=o(28).BaseCollection,s=o(15).make_dbchannel,p=e.Radio.channel("todos"),d="/api/dev/todos",c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.urlRoot=d,n}(u),a=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.url=d,n.prototype.model=c,n}(i),_=new a,s(p,"todo",c,a),t.exports={TodoCollection:a}},49:function(t,n,o){var e,r,i,u,c,p=function(t,n){function o(){this.constructor=t}for(var e in n)a.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},a={}.hasOwnProperty;e=o(10),o(48),r=o(47),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("todos"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.appRoutes={todos:"list_todos","todos/todos/new":"new_todo","todos/todos/edit/:id":"edit_todo","todos/todos/view/:id":"view_todo"},n}(e),i.reply("applet:todos:route",function(){var t,n;t=new r(i),c.reply("main-controller",function(){return t}),n=new u({controller:t})})},139:function(t,n,o){var e,r,i,u,c,p,a,s,l,_,d=function(t,n){function o(){this.constructor=t}for(var e in n)f.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},f={}.hasOwnProperty;s=o(5),i=o(11).MainController,a=o(16).SlideDownRegion,r=Backbone.Radio.channel("global"),p=Backbone.Radio.channel("messages"),u=Backbone.Radio.channel("mappy"),_=o(4),l=_.renderable(function(){return _.div("#main-content.col-sm-12")}),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return d(n,t),n.prototype.template=l,n.prototype.regions=function(){return{content:new a({el:"#main-content",speed:"slow"})}},n}(Backbone.Marionette.View),e=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return d(n,t),n.prototype.layoutClass=c,n.prototype.main_view=function(){return this.setup_layout(),console.log("layout should be ready"),o.e(0,function(t){return function(){var n,e;return n=o(191),e=new n,t.layout.showChildView("content",e),console.log("view shown?",e)}}(this))},n}(i),t.exports=e},140:function(t,n,o){var e,r,i,u,c,p,a,s,l,_=function(t,n){function o(){this.constructor=t}for(var e in n)d.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},d={}.hasOwnProperty;e=o(2),a=o(15).make_dbchannel,p=e.Radio.channel("mappy"),s=o(14),c=s.GhostModel,u=s.GhostCollection,l="/api/dev/mappy/gpslocations",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.urlRoot=l,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.model=r,n.prototype.url=l,n}(u),a(p,"location",r,i)},141:function(t,n,o){var e,r,i,u,c,p=function(t,n){function o(){this.constructor=t}for(var e in n)a.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},a={}.hasOwnProperty;e=o(10),o(140),r=o(139),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("mappy"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.appRoutes={mappy:"main_view"},n}(e),i.reply("applet:mappy:route",function(){var t,n;t=new r(i),u.reply("main-controller",function(){return t}),n=new c({controller:t})})}});