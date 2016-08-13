# # Ghost Configuration
# Setup your Ghost install for various [environments](http://support.ghost.org/config/#about-environments).
# Ghost runs in `development` mode by default. Full documentation can be found at http://support.ghost.org/config/
path = require('path')
config = undefined
config =
  production:
    url: 'http://my-ghost-blog.com'
    mail: {}
    database:
      client: 'sqlite3'
      connection: filename: path.join(__dirname, '/content/data/ghost.db')
      debug: false
    server:
      host: '127.0.0.1'
      port: '2368'
  development:
    url: 'http://localhost:8081/blog'
    database:
      client: 'sqlite3'
      connection: filename: path.join(__dirname, '/content/data/ghost-dev.db')
      debug: false
    server:
      host: '127.0.0.1'
      port: '8081'
    paths:
      contentPath: path.join(__dirname, '/content/')
      subdir: 'blog'
      
module.exports = config
