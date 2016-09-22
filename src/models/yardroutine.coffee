module.exports = (sequelize, DataTypes) ->
  sequelize.define 'yardroutine',
    description:
      type: DataTypes.TEXT
    frequency:
      # measured in days
      type: DataTypes.INTEGER
    leeway:
      # measured in days
      type: DataTypes.INTEGER
    rate:
      # measured in dollars
      type: DataTypes.INTEGER
    routine_date:
      type: DataTypes.DATE
    active:
      type: DataTypes.BOOLEAN
  ,
    underscored: true
    
