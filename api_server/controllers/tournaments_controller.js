var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var util = require('util');
var https = require('https');
var querystring = require('querystring');
var queries = require('../queries/tournament_queries');
var config = require('../config/configuration');
var connectionpool = config.connectionpool;

exports.generalTournaments = function (req, res) {
    var baseUrl = 'https://www.googleapis.com/calendar/v3/calendars/%s/events?%s';
    var dateTime = new Date().toISOString();
    var calendarId = 'le40uvlqte5b3uqg1b2v1h8af4%40group.calendar.google.com';
    var params = {singleEvents: 'true', orderBy:'startTime', timeMin:dateTime, key:process.env.GOOGLE_CALENDAR_KEY};
    var query = querystring.stringify(params);
    var url = util.format(baseUrl, calendarId, query);
    return https.get(url, function (response) {
        var body = '';
        response.on('data', function (chunk) {
            body+=chunk;
        }).on('end', function() {
            body = JSON.parse(body);
            var items = body.items;
            res.send(items);
        });
    }).on('error', function (err) {

    });
};

exports.groupedTournaments = function (req, res) {
	var query = util.format(queries.groupedTournaments, req.params.gid);
    utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
        res.send(json.json);
    });
};

exports.specificTournament = function (req, res) {
    var query = util.format(queries.specificTournament, req.params.id)
    utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
        res.send((json.json)[0]);
    });
};
