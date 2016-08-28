module.exports = (sequelize, DataTypes) ->
  sequelize.define 'maplocation',
    id:
      type: DataTypes.INTEGER
      primaryKey: true
      references:
        model: 'gpslocation'
        key: 'id'
    name:
      type: DataTypes.STRING
    description:
      type: DataTypes.TEXT
