webpackJsonp([5],{0:function(t,n,e){var o,r,i,u,c,s,a;a=e(53).start_with_user,i=e(3),s=e(27),o=e(52),o.set("applets",[{appname:"bumblr",name:"Bumblr",url:"#bumblr"},{appname:"sunny",name:"Clients",url:"#sunny"},{appname:"dbdocs",name:"DB Docs",url:"#dbdocs"},{appname:"todos",name:"To Dos",url:"#todos"}]),r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),r.reply("main:app:appmodel",function(){return o}),e(44),e(51),e(39),e(47),e(42),e(50),c=new i.Application,s(c,o),a(c),t.exports=c},40:function(t,n,e){var o,r,i,u,c,s=function(t,n){function e(){this.constructor=t}for(var o in n)a.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},a={}.hasOwnProperty;i=e(11).MainController,r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),c=Backbone.Radio.channel("resources"),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.collection=c.request("document-collection"),n.prototype.list_pages=function(){return this.setup_layout_if_needed(),console.log("List Pages"),e.e(0,function(t){return function(){var n,o,r;return n=e(116),r=new n({collection:t.collection}),o=t.collection.fetch(),o.done(function(){return t._show_content(r)}),o.fail(function(){return u.request("danger","Failed to load documents.")})}}(this))},n.prototype.edit_page=function(t){return this.setup_layout_if_needed(),e.e(1,function(n){return function(){var o,r;return o=e(33).EditPageView,r=c.request("get-document",t),n._load_view(o,r)}}(this))},n.prototype.new_page=function(){return this.setup_layout_if_needed(),e.e(1,function(t){return function(){var n;return n=e(33).NewPageView,t._show_content(new n)}}(this))},n}(i),t.exports=o},41:function(t,n,e){var o,r,i,u,c,s,a,p,l,_=function(t,n){function e(){this.constructor=t}for(var o in n)d.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},d={}.hasOwnProperty;o=e(2),l=e(14),c=l.GhostModel,u=l.GhostCollection,p=e(16).make_dbchannel,s=o.Radio.channel("resources"),a="/api/dev/sitedocuments",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.urlRoot=a,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.url=a,n.prototype.model=r,n}(u),p(s,"document",r,i),t.exports={DocumentCollection:i}},42:function(t,n,e){var o,r,i,u,c,s=function(t,n){function e(){this.constructor=t}for(var o in n)a.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},a={}.hasOwnProperty;o=e(10),e(41),r=e(40),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("resources"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.appRoutes={dbdocs:"list_pages","dbdocs/documents/new":"new_page","dbdocs/documents/edit/:id":"edit_page"},n}(o),i.reply("applet:dbdocs:route",function(){var t,n;return t=new r(i),n=new c({controller:t})})},43:function(t,n,e){var o,r,i,u,c,s,a,p,l,_,d,f=function(t,n){function e(){this.constructor=t}for(var o in n)y.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},y={}.hasOwnProperty;o=e(2),s=e(3),c=e(11).MainController,_=e(23).login_form,p=e(13).SlideDownRegion,u=o.Radio.channel("global"),a=o.Radio.channel("messages"),d=e(4),l=d.renderable(function(){return d.div("#main-content.col-sm-12")}),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.template=l,n.prototype.regions=function(){return{content:new p({el:"#main-content",speed:"slow"})}},n}(o.Marionette.View),r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.layoutClass=i,n.prototype._view_resource=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r;return o=e(34).FrontDoorMainView,r=new o({model:t}),n.layout.showChildView("content",r)}}(this))},n.prototype._view_login=function(){return e.e(0,function(t){return function(){var n,o;return n=e(117),o=new n,t.layout.showChildView("content",o)}}(this))},n.prototype.view_page=function(t){var n,e;return n=u.request("main:ghost:posts"),e=u.request("main:ghost:get-post",t),e.done(function(e){return function(){var o;return o=n.find({slug:t}),e._view_resource(o)}}(this)),e.fail(function(t){return function(){return a.request("danger","Failed to get document")}}(this))},n.prototype.frontdoor_needuser=function(){var t;return t=u.request("current-user"),t.has("name")?this.frontdoor_hasuser(t):this.show_login()},n.prototype.show_login=function(){return this._view_login()},n.prototype.frontdoor_hasuser=function(t){return this.default_view()},n.prototype.default_view=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n,o,r;return n=e(34).PostList,o=u.request("main:ghost:posts"),r=o.fetch(),r.done(function(){var e;return e=new n({collection:o}),t.layout.showChildView("content",e)})}}(this))},n.prototype.frontdoor=function(){var t;return t=u.request("main:app:appmodel"),t.get("needUser")?(console.log("needUser is true"),this.frontdoor_needuser()):this.default_view()},n}(c),t.exports=r},44:function(t,n,e){var o,r,i,u,c=function(t,n){function e(){this.constructor=t}for(var o in n)s.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},s={}.hasOwnProperty;o=e(10),r=e(43),i=Backbone.Radio.channel("global"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return c(n,t),n.prototype.appRoutes={"":"frontdoor",frontdoor:"frontdoor","frontdoor/view":"frontdoor","frontdoor/view/:name":"view_page","frontdoor/login":"show_login","pages/:name":"view_page"},n}(o),i.reply("applet:frontdoor:route",function(){var t,n;return t=new r(i),n=new u({controller:t})})},45:function(t,n,e){var o,r,i,u,c,s,a,p,l,_,d,f,y,h=function(t,n){function e(){this.constructor=t}for(var o in n)w.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},w={}.hasOwnProperty;r=e(2),s=e(3),_=e(5),y=e(4),f=e(70),c=e(11).MainController,p=e(13).SlideDownRegion,u=r.Radio.channel("global"),a=r.Radio.channel("messages"),l=r.Radio.channel("sunny"),d=y.renderable(function(){return y.div("#main-content.col-sm-12")}),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.template=d,n.prototype.regions=function(){var t;return t=new p({el:"#main-content"}),t.slide_speed=f(".01s"),{content:t}},n}(r.Marionette.View),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.layoutClass=o,n.prototype.clients=l.request("client-collection"),n.prototype.list_clients=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n,o,r;return n=e(118),r=new n({collection:t.clients}),o=t.clients.fetch(),o.done(function(){return t._show_content(r)}),o.fail(function(){return a.request("danger","Failed to load clients.")})}}(this))},n.prototype.new_client=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n;return n=e(35).NewClientView,t.layout.showChildView("content",new n)}}(this))},n.prototype.add_yard=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(36),r=l.request("new-yard"),r.set("sunnyclient_id",t),i=new o({model:r}),n.layout.showChildView("content",i)}}(this))},n.prototype.view_yard=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(36),r=l.request("get-yard",t),r.has("name")?n._show_edit_client(o,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(o,r)}),i.fail(function(){return a.request("danger","Failed to load yard data.")}))}}(this))},n.prototype._show_edit_client=function(t,n){var e;return e=new t({model:n}),this.layout.showChildView("content",e)},n.prototype.edit_client=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(35).EditClientView,r=l.request("get-client",t),r.has("name")?n._show_edit_client(o,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(o,r)}),i.fail(function(){return a.request("danger","Failed to load client data.")}))}}(this))},n.prototype._fetch_yards_and_view_client=function(t,n){var e,o;return e=l.request("yard-collection"),o=e.fetch({data:{sunnyclient_id:t.id}}),o.done(function(o){return function(){var r;return r=new n({model:t,collection:e}),window.cview=r,o.layout.showChildView("content",r)}}(this)),o.fail(function(t){return function(){return a.request("danger","Failed to load yards.")}}(this))},n.prototype.view_client=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(119),r=l.request("get-client",t),r.has("name")?n._fetch_yards_and_view_client(r,o):(i=r.fetch(),i.done(function(){return n._fetch_yards_and_view_client(r,o)}),i.fail(function(){return a.request("danger","Failed to load client data.")}))}}(this))},n}(c),t.exports=i},46:function(t,n,e){var o,r,i,u,c,s,a,p,l,_,d,f,y=function(t,n){function e(){this.constructor=t}for(var o in n)h.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},h={}.hasOwnProperty;o=e(2),_=e(16).make_dbchannel,d=e(14),c=d.GhostModel,u=d.GhostCollection,s=o.Radio.channel("global"),a=o.Radio.channel("sunny"),f="/api/dev/sunny/clients",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.urlRoot=f,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.model=r,n.prototype.url=f,n}(u),_(a,"client",r,i),f="/api/dev/sunny/yards",p=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.urlRoot=f,n}(c),l=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.model=p,n.prototype.url=f,n}(u),_(a,"yard",p,l),t.exports={ClientCollection:i,YardCollection:l}},47:function(t,n,e){var o,r,i,u,c,s=function(t,n){function e(){this.constructor=t}for(var o in n)a.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},a={}.hasOwnProperty;o=e(10),e(46),r=e(45),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("sunny"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.appRoutes={sunny:"list_clients","sunny/clients":"list_clients","sunny/clients/new":"new_client","sunny/clients/edit/:id":"edit_client","sunny/clients/view/:id":"view_client","sunny/yards/add/:client_id":"add_yard","sunny/yards/view/:id":"view_yard"},n}(o),i.reply("applet:sunny:route",function(){var t,n;t=new r(i),c.reply("main-controller",function(){return t}),c.reply("edit-client",function(n){return t.edit_client(n)}),n=new u({controller:t})})},48:function(t,n,e){var o,r,i,u,c,s,a,p,l=function(t,n){function e(){this.constructor=t}for(var o in n)_.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},_={}.hasOwnProperty;a=e(5),i=e(11).MainController,c=e(29),r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),s=Backbone.Radio.channel("todos"),p=new Backbone.Model({entries:[{name:"List",url:"#todos"},{name:"Calendar",url:"#todos/calendar"},{name:"Complete",url:"#todos/completed"}]}),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return l(n,t),n.prototype.sidebarclass=c,n.prototype.sidebar_model=p,n.prototype.collection=s.request("todo-collection"),n.prototype.setup_layout_if_needed=function(){return n.__super__.setup_layout_if_needed.call(this),this._make_sidebar()},n.prototype.list_certain_todos=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(120),i=new o({collection:n.collection}),r=n.collection.fetch({data:{completed:t}}),r.done(function(){return n._show_content(i)}),r.fail(function(){return u.request("danger","Failed to load todos.")})}}(this))},n.prototype.list_completed_todos=function(){return this.list_certain_todos(!0)},n.prototype.list_todos=function(){return this.list_certain_todos(!1)},n.prototype.new_todo=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n;return n=e(37).NewView,t._show_content(new n)}}(this))},n.prototype.edit_todo=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r;return o=e(37).EditView,r=s.request("get-todo",t),n._load_view(o,r,"todo")}}(this))},n.prototype.view_todo=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r;return o=e(121),r=s.request("get-todo",t),n._load_view(o,r,"todo")}}(this))},n}(i),t.exports=o},49:function(t,n,e){var o,r,i,u,c,s,a,p,l,_,d,f=function(t,n){function e(){this.constructor=t}for(var o in n)y.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},y={}.hasOwnProperty;o=e(2),l=e(14),u=l.GhostModel,i=l.GhostCollection,r=e(28).BaseCollection,p=e(16).make_dbchannel,s=o.Radio.channel("todos"),d="/api/dev/todos",c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.urlRoot=d,n.prototype.defaults={completed:!1},n}(u),a=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.url=d,n.prototype.model=c,n}(i),_=new a,p(s,"todo",c,a),t.exports={TodoCollection:a}},50:function(t,n,e){var o,r,i,u,c,s=function(t,n){function e(){this.constructor=t}for(var o in n)a.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},a={}.hasOwnProperty;o=e(10),e(49),r=e(48),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("todos"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return s(n,t),n.prototype.appRoutes={todos:"list_todos","todos/completed":"list_completed_todos","todos/todos/new":"new_todo","todos/todos/edit/:id":"edit_todo","todos/todos/view/:id":"view_todo"},n}(o),i.reply("applet:todos:route",function(){var t,n;t=new r(i),c.reply("main-controller",function(){return t}),n=new u({controller:t})})}});