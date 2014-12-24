var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var util = require('util');
var queries = require('../queries/tournament_queries');
var config = require('../config/configuration');
var connectionpool = config.connectionpool;

exports.groupedTournaments = function (req, res) {
	var query = util.format(queries.baseQuery, req.params.gid);
    utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
        res.send(json.json);
    });
};

exports.specificTournament = function (req, res) {
    var query = util.format(queries.queryString, req.params.id)
    utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
        res.send((json.json)[0]);
    });
};

exports.generalTournaments = function (req, res) {
    var query = util.format(queries.generalTournaments, req.params.gid, req.params.id);
    utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
        res.send(json.json);
    });
}
