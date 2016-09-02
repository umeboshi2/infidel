module.exports = (sequelize, DataTypes) ->
  sequelize.define 'geoposition',
    accuracy:
      type: DataTypes.INTEGER
    altitude:
      type: DataTypes.FLOAT
    altitudeAccuracy:
      type: DataTypes.INTEGER
    heading:
      type: DataTypes.FLOAT
    latitude:
      type: DataTypes.FLOAT
    longitude:
      type: DataTypes.FLOAT
    speed:
      type: DataTypes.FLOAT
  ,
    underscored: true
