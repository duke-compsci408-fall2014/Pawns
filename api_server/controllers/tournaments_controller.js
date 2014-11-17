var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var queries = require('../queries/tournament_queries');
var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });

exports.allTournaments = function (req, res) {
	var query = queries.baseQuery;
    utils.runQuery(connectionpool, query, req, res, doStuff);
}

exports.getTournament = function (req, res) {
	var query = queries.queryString + req.params.id;
    utils.runQuery(connectionpool, query, req, res, doStuff);
}

function doStuff(json, res, req) {
    res.send(json.json);
}