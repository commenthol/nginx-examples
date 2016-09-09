'use strict'

var http = require('http')
var query = require('querystring').parse
var parse = require('url').parse

var middleware = function (req, res) {
  var _query = query(parse(req.url).query)
  var obj = {
    method: req.method,
    url: req.url,
    query: _query,
    headers: req.headers
  }
  var status = _query.status || 200

  res.writeHead(status, {
    'Content-Type': 'application/json'
  })
  res.write(JSON.stringify(obj, null, 2))
  res.end()
}

var server = http.createServer(middleware)

exports.listen = function (port, cb) {
  port = port || 3000
  server._port = port
  server.listen(port, cb)
}

exports.close = function (cb) {
  server.close(cb)
}

if (module === require.main) {
  exports.listen(null, function () {
    console.log('server running on port %s', server._port)
  })
}
