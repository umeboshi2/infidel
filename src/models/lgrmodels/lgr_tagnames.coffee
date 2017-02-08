### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_tagnames', { name:
    type: DataTypes.STRING
    allowNull: false
    defaultValue: undefined
    primaryKey: true }, tableName: 'lgr_tagnames'
