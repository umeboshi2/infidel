### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_meetings', {
    id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      primaryKey: true
    guid:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    title:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    date:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
    time:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    link:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    dept_id:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
      references:
        model: 'lgr_departments'
        key: 'id'
    agenda_status:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    minutes_status:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    rss:
      type: 'BLOB'
      allowNull: true
      defaultValue: undefined
    updated:
      type: DataTypes.DATE
      allowNull: true
      defaultValue: undefined
  },
  tableName: 'lgr_meetings'
  defaultScope:
    attributes:
      exclude: ['createdAt', 'updatedAt']
