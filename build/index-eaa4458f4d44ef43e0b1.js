webpackJsonp([5],{0:function(t,n,e){var o,r,i,u,c,a,p,s,l,_,d,f;d=e(53).start_with_user,i=e(3),_=e(27),s=e(52),p=[{appname:"sunny",name:"Sunny",url:"#sunny"},{appname:"bumblr",name:"Bumblr",url:"#bumblr"},{appname:"todos",name:"Todos",url:"#todos"},{appname:"userprofile",name:"Profile Page",url:"#profile"},{appname:"dbdocs",name:"DB Docs",url:"#dbdocs"},{appname:"mappy",name:"Map",url:"#mappy"}],s.set("applets",p),l=s.get("brand"),l.url="#",s.set({brand:l}),r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),o=Backbone.Radio.channel("static-documents"),f={label:"Sunny",applets:["sunny","todos","dbdocs"],single_applet:!1},a=[f,{label:"Blog",single_applet:!1,url:"/blog"},{label:"Stuff",single_applet:!1,applets:["mappy","bumblr","userprofile"]}],s.set("applet_menus",a),r.reply("main:app:appmodel",function(){return s}),e(44),e(51),e(39),e(143),e(47),e(42),e(50),c=_(s),d(c),t.exports=c},40:function(t,n,e){var o,r,i,u,c,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;i=e(11).MainController,r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),c=Backbone.Radio.channel("resources"),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.collection=c.request("document-collection"),n.prototype.list_pages=function(){return this.setup_layout_if_needed(),console.log("List Pages"),e.e(0,function(t){return function(){var n,o,r;return n=e(116),r=new n({collection:t.collection}),o=t.collection.fetch(),o.done(function(){return t._show_content(r)}),o.fail(function(){return u.request("danger","Failed to load documents.")})}}(this))},n.prototype.edit_page=function(t){return this.setup_layout_if_needed(),e.e(1,function(n){return function(){var o,r;return o=e(33).EditPageView,r=c.request("get-document",t),n._load_view(o,r)}}(this))},n.prototype.new_page=function(){return this.setup_layout_if_needed(),e.e(1,function(t){return function(){var n;return n=e(33).NewPageView,t._show_content(new n)}}(this))},n}(i),t.exports=o},41:function(t,n,e){var o,r,i,u,c,a,p,s,l,_=function(t,n){function e(){this.constructor=t}for(var o in n)d.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},d={}.hasOwnProperty;o=e(2),l=e(14),c=l.GhostModel,u=l.GhostCollection,s=e(16).make_dbchannel,a=o.Radio.channel("resources"),p="/api/dev/basic/sitedocuments",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.urlRoot=p,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.url=p,n.prototype.model=r,n}(u),s(a,"document",r,i),t.exports={DocumentCollection:i}},42:function(t,n,e){var o,r,i,u,c,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(10),e(41),r=e(40),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("resources"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={dbdocs:"list_pages","dbdocs/documents/new":"new_page","dbdocs/documents/edit/:id":"edit_page"},n}(o),i.reply("applet:dbdocs:route",function(){var t,n;return t=new r(i),n=new c({controller:t})})},43:function(t,n,e){var o,r,i,u,c,a,p,s,l,_,d,f=function(t,n){function e(){this.constructor=t}for(var o in n)y.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},y={}.hasOwnProperty;o=e(2),a=e(3),c=e(11).MainController,_=e(23).login_form,s=e(13).SlideDownRegion,u=o.Radio.channel("global"),p=o.Radio.channel("messages"),d=e(4),l=d.renderable(function(){return d.div("#main-content.col-sm-12")}),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.template=l,n.prototype.regions=function(){return{content:new s({el:"#main-content",speed:"slow"})}},n}(o.Marionette.View),r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return f(n,t),n.prototype.layoutClass=i,n.prototype._view_resource=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r;return o=e(34).FrontDoorMainView,r=new o({model:t}),n.layout.showChildView("content",r)}}(this))},n.prototype._view_login=function(){return e.e(0,function(t){return function(){var n,o;return n=e(117),o=new n,t.layout.showChildView("content",o)}}(this))},n.prototype.view_page=function(t){var n,e;return n=u.request("main:ghost:posts"),e=u.request("main:ghost:get-post",t),e.done(function(e){return function(){var o;return o=n.find({slug:t}),e._view_resource(o)}}(this)),e.fail(function(t){return function(){return p.request("danger","Failed to get document")}}(this))},n.prototype.frontdoor_needuser=function(){var t;return t=u.request("current-user"),t.has("name")?this.frontdoor_hasuser(t):this.show_login()},n.prototype.show_login=function(){return this.setup_layout_if_needed(),this._view_login()},n.prototype.frontdoor_hasuser=function(t){return this.default_view()},n.prototype.default_view=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n,o,r;return n=e(34).PostList,o=u.request("main:ghost:posts"),r=o.fetch(),r.done(function(){var e;return e=new n({collection:o}),t.layout.showChildView("content",e)})}}(this))},n.prototype.frontdoor=function(){var t;return t=u.request("main:app:appmodel"),t.get("needUser")?(console.log("needUser is true"),this.frontdoor_needuser()):this.default_view()},n}(c),t.exports=r},44:function(t,n,e){var o,r,i,u,c=function(t,n){function e(){this.constructor=t}for(var o in n)a.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},a={}.hasOwnProperty;o=e(10),r=e(43),i=Backbone.Radio.channel("global"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return c(n,t),n.prototype.appRoutes={"":"frontdoor",frontdoor:"frontdoor","frontdoor/view":"frontdoor","frontdoor/view/:name":"view_page","frontdoor/login":"show_login","pages/:name":"view_page"},n}(o),i.reply("applet:frontdoor:route",function(){var t,n;return t=new r(i),n=new u({controller:t})})},45:function(t,n,e){var o,r,i,u,c,a,p,s,l,_,d,f,y,h=function(t,n){function e(){this.constructor=t}for(var o in n)w.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},w={}.hasOwnProperty;r=e(2),a=e(3),_=e(5),y=e(4),f=e(70),c=e(11).MainController,s=e(13).SlideDownRegion,u=r.Radio.channel("global"),p=r.Radio.channel("messages"),l=r.Radio.channel("sunny"),d=y.renderable(function(){return y.div("#main-content.col-sm-12")}),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.template=d,n.prototype.regions=function(){var t;return t=new s({el:"#main-content"}),t.slide_speed=f(".01s"),{content:t}},n}(r.Marionette.View),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.layoutClass=o,n.prototype.clients=l.request("client-collection"),n.prototype.list_clients=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n,o,r;return n=e(118),r=new n({collection:t.clients}),o=t.clients.fetch(),o.done(function(){return t._show_content(r)}),o.fail(function(){return p.request("danger","Failed to load clients.")})}}(this))},n.prototype.new_client=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n;return n=e(35).NewClientView,t.layout.showChildView("content",new n)}}(this))},n.prototype.add_yard=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(36),r=l.request("new-yard"),r.set("sunnyclient_id",t),i=new o({model:r}),n.layout.showChildView("content",i)}}(this))},n.prototype.view_yard=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(36),r=l.request("get-yard",t),r.has("sunnyclient")?n._show_edit_client(o,r):(i=r.fetch({data:{"include[]":["sunnyclient","geoposition"]}}),i.done(function(){return n._show_edit_client(o,r)}),i.fail(function(){return p.request("danger","Failed to load yard data.")}))}}(this))},n.prototype.yard_routines=function(t){return console.log("yard_routines",t)},n.prototype._show_edit_client=function(t,n){var e;return e=new t({model:n}),this.layout.showChildView("content",e)},n.prototype.edit_client=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(35).EditClientView,r=l.request("get-client",t),r.has("name")?n._show_edit_client(o,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(o,r)}),i.fail(function(){return p.request("danger","Failed to load client data.")}))}}(this))},n.prototype._fetch_yards_and_view_client=function(t,n){var e,o;return e=l.request("yard-collection"),o=e.fetch({data:{sunnyclient_id:t.id}}),o.done(function(o){return function(){var r;return r=new n({model:t,collection:e}),window.cview=r,o.layout.showChildView("content",r)}}(this)),o.fail(function(t){return function(){return p.request("danger","Failed to load yards.")}}(this))},n.prototype.view_client=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(119),r=l.request("get-client",t),r.has("name")?n._fetch_yards_and_view_client(r,o):(i=r.fetch(),i.done(function(){return n._fetch_yards_and_view_client(r,o)}),i.fail(function(){return p.request("danger","Failed to load client data.")}))}}(this))},n}(c),t.exports=i},46:function(t,n,e){var o,r,i,u,c,a,p,s,l,_,d,f,y,h,w,v,m=function(t,n){function e(){this.constructor=t}for(var o in n)g.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},g={}.hasOwnProperty;o=e(2),h=e(16).make_dbchannel,w=e(14),c=w.GhostModel,u=w.GhostCollection,a=o.Radio.channel("global"),p=o.Radio.channel("sunny"),v="/api/dev/basic/sunnyclients",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.urlRoot=v,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.model=r,n.prototype.url=v,n}(u),h(p,"client",r,i),v="/api/dev/basic/yards",s=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.urlRoot=v,n}(c),y=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.model=s,n.prototype.url=v,n}(u),h(p,"yard",s,y),v="/api/dev/basic/yardroutines",l=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.urlRoot=v,n.prototype.defaults={frequency:14,leeway:3,rate:50,active:!0},n}(c),f=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.model=l,n.prototype.url=v,n}(u),h(p,"yardroutine",l,f),v="/api/dev/basic/yardroutinejobs",_=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.urlRoot=v,n}(c),d=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return m(n,t),n.prototype.model=_,n.prototype.url=v,n}(u),h(p,"yardroutinejob",_,d),t.exports={Clients:i,Yards:y,YardRoutines:f,YardRoutineJobs:d}},47:function(t,n,e){var o,r,i,u,c,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(10),e(46),r=e(45),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("sunny"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={sunny:"list_clients","sunny/clients":"list_clients","sunny/clients/new":"new_client","sunny/clients/edit/:id":"edit_client","sunny/clients/view/:id":"view_client","sunny/yards/add/:client_id":"add_yard","sunny/yards/view/:id":"view_yard","sunny/yards/routines/:yard_id":"yard_routines"},n}(o),i.reply("applet:sunny:route",function(){var t,n;t=new r(i),c.reply("main-controller",function(){return t}),c.reply("edit-client",function(n){return t.edit_client(n)}),n=new u({controller:t})})},48:function(t,n,e){var o,r,i,u,c,a,p,s,l,_=function(t,n){function e(){this.constructor=t}for(var o in n)d.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},d={}.hasOwnProperty;p=e(5),i=e(11).MainController,c=e(29),r=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("messages"),a=Backbone.Radio.channel("todos"),l=new Backbone.Model({entries:[{name:"List",url:"#todos"},{name:"Calendar",url:"#todos/calendar"},{name:"Complete",url:"#todos/completed"}]}),s={"true":1,"false":0},o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.sidebarclass=c,n.prototype.sidebar_model=l,n.prototype.collection=a.request("todo-collection"),n.prototype.setup_layout_if_needed=function(){return n.__super__.setup_layout_if_needed.call(this),this._make_sidebar()},n.prototype._load_view=function(t,n,e){var o;return n.isEmpty()||!n.has("created_at")?(o=n.fetch(),o.done(function(e){return function(){return e._show_view(t,n)}}(this)),o.fail(function(t){return function(){var t;return t="Failed to load "+e+" data.",u.request("danger",t)}}(this))):this._show_view(t,n)},n.prototype.list_certain_todos=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r,i;return o=e(121),i=new o({collection:n.collection}),r=n.collection.fetch({data:{completed:t}}),r.done(function(){return n._show_content(i)}),r.fail(function(){return u.request("danger","Failed to load todos.")})}}(this))},n.prototype.list_completed_todos=function(){return this.list_certain_todos(s["true"])},n.prototype.list_todos=function(){return this.list_certain_todos(s["false"])},n.prototype.new_todo=function(){return this.setup_layout_if_needed(),e.e(0,function(t){return function(){var n;return n=e(37).NewView,t._show_content(new n)}}(this))},n.prototype.edit_todo=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r;return o=e(37).EditView,r=a.request("get-todo",t),n._load_view(o,r,"todo")}}(this))},n.prototype.view_todo=function(t){return this.setup_layout_if_needed(),e.e(0,function(n){return function(){var o,r;return o=e(122),r=a.request("get-todo",t),n._load_view(o,r,"todo")}}(this))},n.prototype.view_calendar=function(){return this.setup_layout_if_needed(),e.e(2,function(t){return function(){var n;return n=e(120),t.layout.showChildView("content",new n)}}(this))},n}(i),t.exports=o},49:function(t,n,e){var o,r,i,u,c,a,p,s,l,_,d,f,y,h,w=function(t,n){function e(){this.constructor=t}for(var o in n)v.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},v={}.hasOwnProperty;o=e(2),d=e(14),u=d.GhostModel,i=d.GhostCollection,r=e(28).BaseCollection,_=e(16).make_dbchannel,p=o.Radio.channel("todos"),h="/api/dev/basic/todos",c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.urlRoot=h,n.prototype.defaults={completed:!1},n}(u),s=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.url=h,n.prototype.model=c,n}(i),y=new s,_(p,"todo",c,s),a=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return w(n,t),n.prototype.url="/api/dev/basic/todos/create-cal",n.prototype.model=c,n}(i),f=new a,p.reply("todocal-collection",function(){return f}),l=void 0,p.reply("maincalendar:set-date",function(){var t;return t=$("#maincalendar"),l=t.fullCalendar("getDate")}),p.reply("maincalendar:get-date",function(){return l}),t.exports={TodoCollection:s}},50:function(t,n,e){var o,r,i,u,c,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(10),e(49),r=e(48),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("todos"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={todos:"list_todos","todos/completed":"list_completed_todos","todos/calendar":"view_calendar","todos/todos/new":"new_todo","todos/todos/edit/:id":"edit_todo","todos/todos/view/:id":"view_todo"},n}(o),i.reply("applet:todos:route",function(){var t,n;t=new r(i),c.reply("main-controller",function(){return t}),n=new u({controller:t})})},141:function(t,n,e){var o,r,i,u,c,a,p,s,l,_,d=function(t,n){function e(){this.constructor=t}for(var o in n)f.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},f={}.hasOwnProperty;s=e(5),i=e(11).MainController,p=e(13).SlideDownRegion,r=Backbone.Radio.channel("global"),a=Backbone.Radio.channel("messages"),u=Backbone.Radio.channel("mappy"),_=e(4),l=_.renderable(function(){return _.div("#main-content.col-sm-12")}),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return d(n,t),n.prototype.template=l,n.prototype.regions=function(){return{content:new p({el:"#main-content",speed:"slow"})}},n}(Backbone.Marionette.View),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return d(n,t),n.prototype.layoutClass=c,n.prototype.main_view=function(){return this.setup_layout(),console.log("layout should be ready"),e.e(0,function(t){return function(){var n,o;return n=e(193),o=new n,t.layout.showChildView("content",o),console.log("view shown?",o)}}(this))},n}(i),t.exports=o},142:function(t,n,e){var o,r,i,u,c,a,p,s,l,_=function(t,n){function e(){this.constructor=t}for(var o in n)d.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},d={}.hasOwnProperty;o=e(2),p=e(16).make_dbchannel,a=o.Radio.channel("mappy"),s=e(14),c=s.GhostModel,u=s.GhostCollection,l="/api/dev/mappy/gpslocations",r=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.urlRoot=l,n}(c),i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return _(n,t),n.prototype.model=r,n.prototype.url=l,n}(u),p(a,"location",r,i)},143:function(t,n,e){var o,r,i,u,c,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(10),e(142),r=e(141),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("mappy"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={mappy:"main_view"},n}(o),i.reply("applet:mappy:route",function(){var t,n;t=new r(i),u.reply("main-controller",function(){return t}),n=new c({controller:t})})}});