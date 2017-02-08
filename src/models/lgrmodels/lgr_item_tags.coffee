### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_item_tags', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_items'
        key: 'id'
    tag:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_tagnames'
        key: 'name'
  }, tableName: 'lgr_item_tags'
