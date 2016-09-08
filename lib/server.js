'use strict'

var http = require('http')
var parse = require('url').parse

var query = function (url) {
  var obj = {}
  var q = (parse(url).query)
  if (q) {
    q.split('&')
    .forEach(function (q) {
      var a = q.split(/=/)
      obj[a[0]] = unescape(a[1])
    })
  }
  return obj
} 

var middleware = function (req, res) {
  var _query = query(req.url) || {}
  var obj = {
    url: req.url,
    query: _query,
    method: req.method,
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
    console.log("server running on port %s", server._port)
  })
}
