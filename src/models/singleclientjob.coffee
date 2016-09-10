module.exports = (sequelize, DataTypes) ->
  sequelize.define 'singleclientjob',
    client_id:
      type: DataTypes.INTEGER
      references:
        model: 'client'
        key: 'client_id'
    due_date:
      type: DataTypes.DATE
    start:
      type: DataTypes.DATE
    end:
      type: DataTypes.DATE
    description:
      type: DataTypes.TEXT
    notes:
      type: DataTypes.TEXT
    rate:
      # measured in dollars
      type: DataTypes.INTEGER
    status:
      type: DataTypes.STRING
  ,
    underscored: true
    
