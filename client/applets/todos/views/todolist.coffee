Templates = require 'agate/src/templates/basecrud'
Views = require 'agate/src/basecrudviews'

class ItemView extends Views.BaseItemView
  route_name: 'todos'
  template: Templates.base_item_template 'todo', 'todos'
  item_type: 'todo'
  
class ListView extends Views.BaseListView
  route_name: 'todos'
  childView: ItemView
  template: Templates.base_list_template 'todo'
  childViewContainer: '#todo-container'
  item_type: 'todo'
    
module.exports = ListView

