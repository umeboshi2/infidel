# inspired by https://github.com/KyleAMathews/coffee-react-quickstart
# 
fs = require 'fs'

gulp = require 'gulp'
gutil = require 'gulp-util'
size = require 'gulp-size'
compass = require 'gulp-compass'
nodemon = require 'gulp-nodemon'

coffee = require 'gulp-coffee'
#runSequence = require 'run-sequence'
#concat = require 'gulp-concat'
#uglify = require 'gulp-uglify'

webpack = require 'webpack'
tc = require 'teacup'

css_theme = 'cornsilk'

gulp.task 'compass', () ->
  gulp.src('./sass/*.scss')
  .pipe compass
    config_file: './config.rb'
    css: 'assets/stylesheets'
    sass: 'sass'
  .pipe size()
  .pipe gulp.dest 'assets/stylesheets'


gulp.task 'coffee', () ->
  gulp.src('./src/**/*.coffee')
  .pipe coffee
    bare: true
  .on 'error', gutil.log
  .pipe size
    showFiles: true
  .pipe gulp.dest './js'

gulp.task 'ghost-config', () ->
  gulp.src('./config.coffee')
  .pipe coffee
    bare: true
  .on 'error', gutil.log
  .pipe size
    showFiles: true
  .pipe gulp.dest './'

gulp.task 'serve', ['ghost-config'], (callback) ->
  process.env.__DEV_MIDDLEWARE__ = 'true'
  nodemon
    script: 'server.js'
    watch: [
      'src'
      'webpack-config'
      'webpack.config.coffee'
      ]
  
gulp.task 'serve:prod', (callback) ->
  process.env.__DEV_MIDDLEWARE__ = 'false'
  nodemon
    script: 'server.js'
    watch: [
      'src/'
      'webpack-config/'
      'webpack.config.coffee'
      ]
  
gulp.task 'webpack:build-prod', (callback) ->
  # run webpack
  process.env.PRODUCTION_BUILD = 'true'
  ProdConfig = require './webpack.config'
  prodCompiler = webpack ProdConfig
  prodCompiler.run (err, stats) ->
    throw new gutil.PluginError('webpack:build-prod', err) if err
    gutil.log "[webpack:build-prod]", stats.toString(colors: true)
    callback()
    return
  return

gulp.task 'default', ->
  gulp.start 'serve'
  
gulp.task 'production', ->
  gulp.start 'compass'
  gulp.start 'webpack:build-prod'
