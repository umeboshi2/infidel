### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_main_cache', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      primaryKey: true
    name:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    retrieved:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
    updated:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
    content:
      type: 'BLOB'
      allowNull: true
      defaultValue: undefined
  }, tableName: 'lgr_main_cache'
