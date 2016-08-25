module.exports = (sequelize, DataTypes) ->
  sequelize.define 'gpslocation',
    lat:
      type: DataTypes.FLOAT
    long:
      type: DataTypes.FLOAT
    # reserve a column for altitude
    alt:
      type: DataTypes.FLOAT
