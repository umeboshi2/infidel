webpackJsonp([5],[function(n,a,e){var l,t,r,o,p,s,b,c,u;u=e(33).start_with_user,o=e(3),c=e(23),l=e(32),l.set("applets",[{name:"Clients",url:"/sunny"},{appname:"bumblr",name:"Bumblr",url:"#bumblr"}]),b=l.get("brand"),b.url="#",l.set({brand:b}),r=Backbone.Radio.channel("global"),p=Backbone.Radio.channel("messages"),t=Backbone.Radio.channel("static-documents"),r.reply("main:app:appmodel",function(){return l}),e(34),e(31),e(30),s=new o.Application,c(s,l),u(s),n.exports=s}]);