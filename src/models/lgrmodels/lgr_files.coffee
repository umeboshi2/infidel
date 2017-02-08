### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_files', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      primaryKey: true
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
  }, tableName: 'lgr_files'
