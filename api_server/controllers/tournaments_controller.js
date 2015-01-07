var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var util = require('util');
var https = require('https');
var redis = require('redis');
var client = redis.createClient();
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

    client.get('tournaments', function(err, reply) {
        if (reply) {
            res.send(JSON.parse(reply).items);
        }
        else {
            https.get(url, function (response) {
                var body = '';
                response.on('data', function (chunk) {
                    body+=chunk;
                }).on('end', function() {
                    client.set('tournaments', body);
                    client.expire('tournaments', 86400); // Daily Expiration
                    body = JSON.parse(body);
                    var items = body.items;
                    res.send(items);
                });
            }).on('error', function (err) {
                console.log(err);
            });

        }
    });
};

exports.specificTournament = function (req, res) {
    var url = 'https://www.googleapis.com/calendar/v3/calendars/le40uvlqte5b3uqg1b2v1h8af4%40group.calendar.google.com/events/%s?key=%s';
    url = util.format(url, req.params.id, process.env.GOOGLE_CALENDAR_KEY);
    client.get(req.params.id, function(err, reply) {
        if (reply) {
            res.send(JSON.parse(reply));
        }
        else {
            https.get(url, function (response) {
                var body = '';
                response.on('data', function (chunk) {
                    body+=chunk;
                }).on('end', function() {
                    client.set(req.params.id, body);
                    body = JSON.parse(body);
                    res.send(body);
                });
            }).on('error', function (err) {
                console.log(err);
            });

        }
    });
};
