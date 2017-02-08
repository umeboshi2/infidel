### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_people', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      primaryKey: true
    guid:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    firstname:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    lastname:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    website:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    photo_link:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    notes:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
  }, tableName: 'lgr_people'
