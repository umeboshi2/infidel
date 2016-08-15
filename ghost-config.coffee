# # Ghost Configuration
# Setup your Ghost install for various [environments](http://support.ghost.org/config/#about-environments).
# Ghost runs in `development` mode by default. Full documentation can be found at http://support.ghost.org/config/
path = require('path')
os = require 'os'
devUrl = "http://localhost:8081/blog"

config = undefined
config =
  production:
    url: 'http://my-ghost-blog.com/blog'
    mail: {}
    database:
      client: 'sqlite3'
      # trailing slash on OPENSHIFT_DATA_DIR
      connection: filename: "#{process.env.OPENSHIFT_DATA_DIR}sunny.sqlite"
      debug: false
    server:
      host: '127.0.0.1'
      port: '2368'
  development:
    url: devUrl
    database:
      client: 'sqlite3'
      connection: filename: path.join __dirname, '/sunny.sqlite'
      debug: false
    server:
      host: '127.0.0.1'
      port: '8081'
    paths:
      contentPath: path.join(__dirname, '/content/')
      subdir: 'blog'
      
module.exports = config
