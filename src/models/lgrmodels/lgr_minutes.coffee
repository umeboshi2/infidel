### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_minutes', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_meetings'
        key: 'id'
      primaryKey: true
    guid:
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
  }, tableName: 'lgr_minutes'
