webpackJsonp([11],{56:function(e,t,n){var r,i,o,u,s,l,a,p,c,f,d,_,h,y,m,v,g,w=function(e,t){function n(){this.constructor=e}for(var r in t)b.call(t,r)&&(e[r]=t[r]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},b={}.hasOwnProperty;c=n(6),r=n(0),o=n(97),m=n(4),y=m.navigate_to_url,_=m.make_field_input_ui,f=m.capitalize,g=n(3),v=n(21),d=v.make_field_input,h=v.make_field_textarea,s=r.Radio.channel("global"),l=r.Radio.channel("messages"),p=r.Radio.channel("sunny"),i=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return w(t,e),t.prototype.fieldList=["name","fullname","email"],t.prototype.templateContext=function(){return{fieldList:this.fieldList}},t.prototype.template=g.renderable(function(e){var t,n,r,i;for(g.div(".listview-header","Client"),i=e.fieldList,n=0,r=i.length;n<r;n++)t=i[n],d(t)(e);return h("description")(e),g.input(".btn.btn-default",{type:"submit",value:"Submit"}),g.div(".spinner.fa.fa-spinner.fa-spin")}),t.prototype.ui=function(){var e;return e=_(this.fieldList),c.extend(e,{description:'textarea[name="description"]'}),e},t.prototype.updateModel=function(){var e,t,n,r,i,o;for(r=this.fieldList.concat(["description"]),i=[],t=0,n=r.length;t<n;t++)e=r[t],o=this.ui[e].val(),console.log("field",e,o),"fullname"!==e||o||(console.log("no fullname here....."),o=f(this.model.get("name"))),i.push(this.model.set(e,o));return i},t.prototype.onSuccess=function(e){var t;return t=e.get("name"),l.request("success",t+" saved successfully.","grain"),y("#sunny")},t}(o),a=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return w(t,e),t.prototype.createModel=function(){return p.request("new-client")},t.prototype.saveModel=function(){var e;return e=p.request("client-collection"),e.add(this.model),t.__super__.saveModel.apply(this,arguments)},t}(i),u=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return w(t,e),t.prototype.createModel=function(){return this.model},t}(i),e.exports={NewClientView:a,EditClientView:u}}});