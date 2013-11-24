
fs = require 'fs'
jade = require 'jade'
express = require 'express'
coffee = require 'coffee-script'

app = express()

app.get '/', (req, res) ->
  fs.readFile './assets/index.jade', (err, buf) ->
    fn = jade.compile buf.toString(), { pretty: true }
    res.send 200, fn()

app.get '/script', (req, res) ->
  fs.readFile './assets/index.coffee', (err, buf) ->
    try
      res.send 200, coffee.compile buf.toString()
    catch e
      res.set 'content-type', 'text/plain'
      res.send 500, e.stack

app.listen 4000
