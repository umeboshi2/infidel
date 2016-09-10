Backbone = require 'backbone'

{ GhostModel
  GhostCollection } = require '../../ghost/base'


{ BaseCollection } = require 'agate/src/collections'
{ make_dbchannel } = require 'agate/src/basecrudchannel'

TodoChannel = Backbone.Radio.channel 'todos'

url = '/api/dev/todos'
class Todo extends GhostModel
  urlRoot: url
  defaults:
    completed: false
    

class TodoCollection extends GhostCollection
  url: url
  model: Todo


todo_collection = new TodoCollection()

make_dbchannel TodoChannel, 'todo', Todo, TodoCollection

class TodoCalendar extends GhostCollection
  url: "/api/dev/sunny/funny/todocal"
  model: Todo

todo_cal = new TodoCalendar
TodoChannel.reply 'todocal-collection', ->
  todo_cal


current_calendar_date = undefined
TodoChannel.reply 'maincalendar:set-date', () ->
  cal = $ '#maincalendar'
  current_calendar_date = cal.fullCalendar 'getDate'

TodoChannel.reply 'maincalendar:get-date', () ->
  current_calendar_date
  
if __DEV__
  window.todo_collection = todo_collection

module.exports =
  TodoCollection: TodoCollection
