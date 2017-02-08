### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_actions', {
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
    mover_id:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
      references:
        model: 'lgr_people'
        key: 'id'
    seconder_id:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
      references:
        model: 'lgr_people'
        key: 'id'
    result:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    agenda_note:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    minutes_note:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    action:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    action_text:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
  }, tableName: 'lgr_actions'
