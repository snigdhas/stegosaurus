var http = require('http');
var path = require('path');
var fs = require('fs');

function handleRequest(req, res) {
  var pathname = req.url;

  if (pathname == '/') {
    pathname = '/index.html';
  }

  var ext = path.extname(pathname);
  var typeExt = {
    '.html': 'text/html',
    '.js':   'text/javascript',
  };

  var contentType = typeExt[ext] || 'text/plain';
  fs.readFile(__dirname + pathname,
    function (err, data) {
      if (err) {
        res.writeHead(500);
        return res.end('Error loading ' + pathname);
      }
      // Dynamically setting content type
      res.writeHead(200,{ 'Content-Type': contentType });
        res.end(data);
    }
  );
}
