module.exports = (sequelize, DataTypes) ->
  sequelize.define 'userconfig',
    user_id:
      type: DataTypes.INTEGER
    config:
      # FIXME
      # this should be json on postgresql
      # should use config to determine if get/set and text are needed
      type: DataTypes.TEXT
      get: ->
        JSON.parse @getDataValue 'config'
      set: (value) ->
        @setDataValue 'config', JSON.stringify(value)

