var UseMiddleware,beautify,make_page,make_page_header,make_page_html,pages,webpackManifest,write_page;beautify=require("js-beautify").html,pages=require("./templates"),webpackManifest=require("../../build/manifest.json"),UseMiddleware="true"===process.env.__DEV__,make_page_html=function(e,a){var t,r,n;return UseMiddleware?(r={"vendor.js":"vendor.js","agate.js":"agate.js"},t=e+".js",r[t]=t):r=webpackManifest,n=pages[e](r,a),beautify(n)},make_page_header=function(e,a){return e.writeHead(200,{"Content-Length":Buffer.byteLength(a),"Content-Type":"text/html"})},write_page=function(e,a,t){return make_page_header(a,e),a.write(e),a.end(),t()},make_page=function(e){return function(a,t,r){var n,i,s;return s="custom",a.isAuthenticated()&&(n=a.user.config,s=n.theme),i=make_page_html(e,s),write_page(i,t,r)}},module.exports={make_page:make_page};