module.exports = (sequelize, DataTypes) ->
  sequelize.define 'sunnyclient',
    name:
      type: DataTypes.STRING
      unique: true
    fullname:
      type: DataTypes.TEXT
    description:
      type: DataTypes.TEXT
  ,
    underscored: true
