### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_items', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      primaryKey: true
    guid:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    file_id:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    filetype:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    name:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    title:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    status:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    passed:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
    on_agenda:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
    introduced:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
    acted_on:
      type: DataTypes.BOOLEAN
      allowNull: true
      defaultValue: undefined
  }, tableName: 'lgr_items'
