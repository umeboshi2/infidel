module.exports = (sequelize, DataTypes) ->
  sequelize.define 'yard',
    #client_id:
    #  type: DataTypes.INTEGER
    #  references:
    #    model: 'sunnyclient'
    #    key: 'id'
    #location_id:
    #  type: DataTypes.INTEGER
    #  references:
    #    model: 'geoposition'
    #    key: 'id'
    name:
      type: DataTypes.STRING
    description:
      type: DataTypes.TEXT
    jobdetails:
      type: DataTypes.TEXT
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
    
