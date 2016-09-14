module.exports = (sequelize, DataTypes) ->
  sequelize.define 'sunnyclient',
    name:
      type: DataTypes.STRING
      unique: true
    fullname:
      type: DataTypes.STRING
    email:
      type: DataTypes.STRING
    description:
      type: DataTypes.TEXT
  ,
    underscored: true
