### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_attachments', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      primaryKey: true
    guid:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    name:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    http_info:
      type: 'BLOB'
      allowNull: true
      defaultValue: undefined
    content:
      type: 'BLOB'
      allowNull: true
      defaultValue: undefined
    link:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    item_id:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
      references:
        model: 'lgr_items'
        key: 'id'
  }, tableName: 'lgr_attachments'
