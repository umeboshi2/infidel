webpackJsonp([3],{0:function(t,n,e){var o,r,i,c,u,a,p;p=e(32).start_with_user,i=e(3),a=e(24),o=e(31),o.set("applets",[{appname:"bumblr",name:"Bumblr",url:"#bumblr"},{appname:"sunny",name:"Clients",url:"#sunny"},{appname:"dbdocs",name:"DB Docs",url:"#dbdocs"},{appname:"todos",name:"To Dos",url:"#todos"}]),r=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("messages"),r.reply("main:app:appmodel",function(){return o}),e(29),e(30),e(28),e(119),e(115),e(122),u=new i.Application,a(u,o),p(u),t.exports=u},113:function(t,n,e){var o,r,i,c,u,a,p,l=function(t,n){function e(){this.constructor=t}for(var o in n)s.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},s={}.hasOwnProperty;u=e(13).MainController,c=Backbone.Radio.channel("global"),a=Backbone.Radio.channel("messages"),p=Backbone.Radio.channel("resources"),r={html:"Document",markdown:"MarkDownDocument"},o={Document:"html",MarkDownDocument:"markdown"},i=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return l(n,t),n.prototype._get_doc_and_render_view=function(t){var n;return this._make_editbar(),n=new t({model:this.root_doc}),this._show_content(n)},n.prototype.list_pages=function(){return console.log("List Pages"),e.e(1,function(t){return function(){var n,o;return n=e(170),o=new n({collection:p.request("app-documents")}),t._show_content(o)}}(this))},n.prototype.edit_page=function(t){return e.e(1,function(n){return function(){var o;return o=e(91).EditPageView,n._show_content(new o({model:p.request("get-document",t)}))}}(this))},n.prototype.new_page=function(){return e.e(1,function(t){return function(){var n;return n=e(91).NewPageView,t._show_content(new n)}}(this))},n}(u),t.exports=i},114:function(t,n,e){var o,r,i,c,u,a,p,l,s,d,_,f,y=function(t,n){function e(){this.constructor=t}for(var o in n)w.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},w={}.hasOwnProperty;o=e(5),d=e(4),r=e(2),p=e(3),i=e(20).BaseCollection,a=r.Radio.channel("global"),l=r.Radio.channel("messages"),s=r.Radio.channel("resources"),_="/api/dev/sitedocuments",c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.idAttribute="name",n.prototype.urlRoot=_,n.prototype.defaults={name:"",doctype:"markdown",title:"",content:"",description:""},n}(r.Model),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return y(n,t),n.prototype.url=_,n.prototype.model=c,n}(i),f=new u,s.reply("app-documents",function(){return f}),s.reply("get-document",function(t){var n;return n=f.get(name),void 0===n?new c({id:t}):n}),s.reply("new-document",function(){return new c}),s.reply("add-document",function(t,n,e,o){var r;return r=s.request("app-documents"),new c}),t.exports={DocumentCollection:u}},115:function(t,n,e){var o,r,i,c,u,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(12),r=e(113),e(114),i=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("resources"),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={dbdocs:"list_pages","dbdocs/newpage":"new_page","dbdocs/edit/:name":"edit_page"},n}(o),i.reply("applet:dbdocs:route",function(){var t,n;return t=new r(i),t.root_doc=c.request("get-document","startdoc"),n=new u({controller:t})})},117:function(t,n,e){var o,r,i,c,u,a,p=function(t,n){function e(){this.constructor=t}for(var o in n)l.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},l={}.hasOwnProperty;a=e(11),i=e(13).MainController,r=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("messages"),u=Backbone.Radio.channel("sunny"),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype._get_doc_and_render_view=function(t){var n;return this._make_editbar(),n=new t({model:this.root_doc}),this._show_content(n)},n.prototype.clients=u.request("client-collection"),n.prototype.list_clients=function(){return e.e(0,function(t){return function(){var n,o,r;return n=e(172),r=new n({collection:t.clients}),o=t.clients.fetch(),o.done(function(){return t._show_content(r)}),o.fail(function(){return c.request("danger","Failed to load clients.")})}}(this))},n.prototype.new_client=function(){return e.e(0,function(t){return function(){var n;return n=e(92).NewClientView,t._show_content(new n)}}(this))},n.prototype.add_yard=function(t){return e.e(0,function(t){return function(){var n;return n=e(174).NewYardView,t._show_content(new n)}}(this))},n.prototype._show_edit_client=function(t,n){var e;return e=new t({model:n}),this._show_content(e)},n.prototype.edit_client=function(t){return e.e(0,function(n){return function(){var o,r,i;return o=e(92).EditClientView,r=u.request("get-client",t),r.has("name")?n._show_edit_client(o,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(o,r)}),i.fail(function(){return c.request("danger","Failed to load client data.")}))}}(this))},n.prototype.view_client=function(t){return e.e(0,function(n){return function(){var o,r,i;return o=e(173),r=u.request("get-client",t),r.has("name")?n._show_edit_client(o,r):(i=r.fetch(),i.done(function(){return n._show_edit_client(o,r)}),i.fail(function(){return c.request("danger","Failed to load client data.")}))}}(this))},n}(i),t.exports=o},118:function(t,n,e){var o,r,i,c,u,a,p,l,s,d,_,f,y,w,h=function(t,n){function e(){this.constructor=t}for(var o in n)v.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},v={}.hasOwnProperty;o=e(5),f=e(4),r=e(2),p=e(3),i=e(20).BaseCollection,a=r.Radio.channel("global"),l=r.Radio.channel("messages"),s=r.Radio.channel("sunny"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.urlRoot="/api/dev/sunny/clients",n}(r.Model),u=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.model=c,n.prototype.url="/api/dev/sunny/clients",n}(r.Collection),y=new u,s.reply("client-collection",function(){return y}),s.reply("new-client",function(){return new c}),s.reply("add-client",function(t){var n,e,o;n=y.create();for(e in t)o=t[e],n.set(e,o);return y.add(n),n.save()}),s.reply("get-client",function(t){var n;return n=y.get(t),void 0===n?new c({id:t}):n}),d=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.urlRoot="/api/dev/sunny/yards",n}(r.Model),_=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.model=d,n.prototype.url="/api/dev/sunny/yards",n}(r.Collection),w=new _,s.reply("yard-collection",function(){return w}),s.reply("new-yard",function(){return new d}),s.reply("add-yard",function(t){var n,e,o;o=w.create();for(n in t)e=t[n],o.set(n,e);return w.add(o),o.save()}),s.reply("get-yard",function(t){var n;return n=w.get(t),void 0===n?new d({id:t}):n}),t.exports={ClientCollection:u,YardCollection:_}},119:function(t,n,e){var o,r,i,c,u,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(12),e(118),r=e(117),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("sunny"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={sunny:"list_clients","sunny/clients":"list_clients","sunny/clients/new":"new_client","sunny/clients/edit/:id":"edit_client","sunny/clients/view/:id":"view_client","sunny/clients/addyard/:client_id":"add_yard"},n}(o),i.reply("applet:sunny:route",function(){var t,n;t=new r(i),u.reply("main-controller",function(){return t}),u.reply("edit-client",function(n){return t.edit_client(n)}),n=new c({controller:t})})},120:function(t,n,e){var o,r,i,c,u,a,p=function(t,n){function e(){this.constructor=t}for(var o in n)l.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},l={}.hasOwnProperty;a=e(11),i=e(13).MainController,r=Backbone.Radio.channel("global"),c=Backbone.Radio.channel("messages"),u=Backbone.Radio.channel("todos"),o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.collection=u.request("todo-collection"),n.prototype.list_todos=function(){return e.e(0,function(t){return function(){var n,o,r;return n=e(175),r=new n({collection:t.collection}),o=t.collection.fetch(),o.done(function(){return t._show_content(r)}),o.fail(function(){return c.request("danger","Failed to load todos.")})}}(this))},n.prototype.new_todo=function(){return e.e(0,function(t){return function(){var n;return n=e(93).NewView,t._show_content(new n)}}(this))},n.prototype.edit_todo=function(t){return e.e(0,function(n){return function(){var o,r;return o=e(93).EditView,r=u.request("get-todo",t),n._load_view(o,r,"todo")}}(this))},n.prototype.view_todo=function(t){return e.e(0,function(n){return function(){var o,r;return o=e(176),r=u.request("get-todo",t),n._load_view(o,r,"todo")}}(this))},n}(i),t.exports=o},121:function(t,n,e){var o,r,i,c,u,a,p,l,s,d,_,f,y,w,h=function(t,n){function e(){this.constructor=t}for(var o in n)v.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},v={}.hasOwnProperty;o=e(5),d=e(4),r=e(2),u=e(3),i=e(20).BaseCollection,y=e(11),_=y.create_model,f=y.get_model,c=r.Radio.channel("global"),a=r.Radio.channel("messages"),l=r.Radio.channel("todos"),p=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.urlRoot="/api/dev/todos",n}(r.Model),s=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return h(n,t),n.prototype.url="/api/dev/todos",n.prototype.model=p,n}(r.Collection),w=new s,l.reply("todo-collection",function(){return w}),l.reply("new-todo",function(){return new p}),l.reply("add-todo",function(t){return _(w,t)}),l.reply("get-todo",function(t){return f(w,t)}),t.exports={TodoCollection:s}},122:function(t,n,e){var o,r,i,c,u,a=function(t,n){function e(){this.constructor=t}for(var o in n)p.call(n,o)&&(t[o]=n[o]);return e.prototype=n.prototype,t.prototype=new e,t.__super__=n.prototype,t},p={}.hasOwnProperty;o=e(12),e(121),r=e(120),i=Backbone.Radio.channel("global"),u=Backbone.Radio.channel("todos"),c=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return a(n,t),n.prototype.appRoutes={todos:"list_todos","todos/todos/new":"new_todo","todos/todos/edit/:id":"edit_todo","todos/todos/view/:id":"view_todo"},n}(o),i.reply("applet:todos:route",function(){var t,n;t=new r(i),u.reply("main-controller",function(){return t}),n=new c({controller:t})})}});