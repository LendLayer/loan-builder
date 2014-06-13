var gzippo = require('gzippo');
var express = require('express');
var app = express();
var port = process.env.PORT || 5000;
 
app.use(express.logger('dev'));
app.use(gzippo.staticGzip("" + __dirname + "/dist"));
console.log("serving on port " + port)
app.listen(port);
