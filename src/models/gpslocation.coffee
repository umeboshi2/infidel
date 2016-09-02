module.exports = (sequelize, DataTypes) ->
  sequelize.define 'gpslocation',
    latitude:
      type: DataTypes.FLOAT
    longitude:
      type: DataTypes.FLOAT
    # reserve a column for altitude
    altitude:
      type: DataTypes.FLOAT
  ,
    underscored: true
