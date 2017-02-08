### jshint indent: 2 ###

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'lgr_action_vote', {
    action_id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_actions'
        key: 'id'
    person_id:
      type: DataTypes.INTEGER
      allowNull: false
      defaultValue: undefined
      references:
        model: 'lgr_people'
        key: 'id'
    vote:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: undefined
  }, tableName: 'lgr_action_vote'
