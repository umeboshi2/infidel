Templates = require '../templates'
Views = require './base'

class ItemView extends Views.BaseItemView
  template: Templates.base_item_template 'todo'
  item_type: 'todo'
  
class ListView extends Views.BaseListView
  childView: ItemView
  template: Templates.base_list_template 'todo'
  childViewContainer: '#todo-container'
  item_type: 'todo'
    
module.exports = ListView

