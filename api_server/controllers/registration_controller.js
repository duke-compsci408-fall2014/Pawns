var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var qs = require('querystring')
var queries = require('../queries/registration_queries');
var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });

exports.register = function (req, res) {

    var body = '';
    req.on('data', function (data) {
        body += data;
        if(body.length > 1e6) {
            request.connection.destroy();
        }
    })
    req.on('end', function () {
        var object = {};
        var post = JSON.parse(body);

        object['username'] = post.username;
        object['tournament_id'] = post.tournament_id;
        object = JSON.stringify(object);
        var query = queries.register;

        utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
            console.log(object);
            res.send(object);
        });
    });
};
