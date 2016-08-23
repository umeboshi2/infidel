var config, devUrl, os, path;

path = require('path');

os = require('os');

devUrl = "http://localhost:8081/blog";

config = void 0;

config = {
  production: {
    url: 'https://infidel-frobozz.rhcloud.com/blog',
    mail: {},
    database: {
      client: 'sqlite3',
      connection: {
        filename: process.env.OPENSHIFT_DATA_DIR + "sunny.sqlite"
      },
      debug: false
    },
    server: {
      host: '127.0.0.1',
      port: '2368'
    }
  },
  development: {
    url: devUrl,
    database: {
      client: 'sqlite3',
      connection: {
        filename: path.join(__dirname, '/sunny.sqlite')
      },
      debug: false
    },
    server: {
      host: '127.0.0.1',
      port: '8081'
    },
    paths: {
      contentPath: path.join(__dirname, '/content/'),
      subdir: 'blog'
    }
  }
};

module.exports = config;
