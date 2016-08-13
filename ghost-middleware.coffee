ghost = require('ghost')

processBuffer = (buffer, app) ->
  while buffer.length
    request = buffer.pop()
    app request[0], request[1]
  return

makeGhostMiddleware = (options) ->
  requestBuffer = []
  app = false
  ghost(options).then (ghost) ->
    app = ghost.rootApp
    processBuffer requestBuffer, app
    handleRequest = (req, res) ->
      if !app
        requestBuffer.unshift [
          req
          res
        ]
      else
        app req, res
    handleRequest

module.exports = makeGhostMiddleware
