var admin,base_page,index,sunny,tc;tc=require("teacup"),base_page=tc.renderable(function(t,e,n){return tc.doctype(),tc.html({xmlns:"http://www.w3.org/1999/xhtml"},function(){return tc.head(function(){return tc.meta({charset:"utf-8"}),tc.meta({name:"viewport",content:"width=device-width, initial-scale=1"}),tc.link({rel:"stylesheet",type:"text/css",href:"assets/stylesheets/font-awesome.css"}),tc.link({rel:"stylesheet",type:"text/css",href:"assets/stylesheets/bootstrap-"+n+".css"})}),tc.body(function(){return tc.div(".container-fluid",function(){return tc.div(".row",function(){return tc.div(".col-sm-2"),tc.div(".col-sm-6.jumbotron",function(){return tc.h1(function(){return tc.text("Loading ..."),tc.i(".fa.fa-spinner.fa-spin")})}),tc.div(".col-sm-2")})}),tc.script({type:"text/javascript",charset:"utf-8",src:"build/"+e["vendor.js"]}),tc.script({type:"text/javascript",charset:"utf-8",src:"build/"+e[t]})})})}),index=function(t,e){return base_page("index.js",t,e)},sunny=function(t,e){return base_page("sunny.js",t,e)},admin=function(t,e){return base_page("admin.js",t,e)},module.exports={index:index,sunny:sunny,admin:admin};