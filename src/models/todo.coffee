module.exports = (sequelize, DataTypes) ->
  sequelize.define 'todo',
    description:
      type: DataTypes.TEXT
    completed:
      type: DataTypes.BOOLEAN
