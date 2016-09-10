module.exports = (sequelize, DataTypes) ->
  sequelize.define 'yardroutinejob',
    routine_id:
      type: DataTypes.INTEGER
      references:
        model: 'yardroutine'
        key: 'yard_id'
    due_date:
      type: DataTypes.DATE
    start:
      type: DataTypes.DATE
    end:
      type: DataTypes.DATE
    notes:
      type: DataTypes.TEXT
    extra:
      type: DataTypes.TEXT
    extra_rate:
      # measured in dollars
      type: DataTypes.INTEGER
    status:
      type: DataTypes.STRING
  ,
    underscored: true
    
