### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_meeting_item', {
    meeting_id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_meetings'
        key: 'id'
    item_id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_items'
        key: 'id'
    agenda_num:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    type:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
    order:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
    item_order:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
    version:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: undefined
  }, tableName: 'lgr_meeting_item'
