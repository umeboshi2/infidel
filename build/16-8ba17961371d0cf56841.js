webpackJsonp([16],{149:function(t,e,o){var n,p,r,i,c,u,s=function(t,e){function o(){this.constructor=t}for(var n in e)y.call(e,n)&&(t[n]=e[n]);return o.prototype=e.prototype,t.prototype=new o,t.__super__=e.prototype,t},y={}.hasOwnProperty;c=o(99),u=o(98),n=c.base_item_template("client","sunny"),r=c.base_list_template("client"),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.route_name="sunny",e.prototype.template=n,e.prototype.item_type="client",e}(u.BaseItemView),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return s(e,t),e.prototype.route_name="sunny",e.prototype.childView=p,e.prototype.template=r,e.prototype.childViewContainer="#client-container",e.prototype.item_type="client",e}(u.BaseListView),t.exports=i}});