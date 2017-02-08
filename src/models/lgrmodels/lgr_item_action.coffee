### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_item_action', {
    item_id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_items'
        key: 'id'
    action_id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_actions'
        key: 'id'
  }, tableName: 'lgr_item_action'
