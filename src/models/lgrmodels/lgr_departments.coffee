### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_departments', {
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
  }, tableName: 'lgr_departments'
