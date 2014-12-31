var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var util = require('util');
var utils = require('../utils');
var qs = require('querystring')
var queries = require('../queries/registration_queries');
var config = require('../config/configuration');
var connectionpool = config.connectionpool;

exports.register = function (req, res) {

    var body = '';
    req.on('data', function (data) {
        body += data;
        if(body.length > 1e6) {
            request.connection.destroy();
        }
    });
    req.on('end', function () {
        var object = {};
        var post = JSON.parse(body);
        console.log(post);
        object['username'] = post.username;
        object['tournament_id'] = post.tournament_id;
        object = JSON.stringify(object);

        var userData = util.format(queries.getUserData, post.tournament_id, '\"'+post.username+'\"');

        utils.runQuery(connectionpool, userData, req, res, function (json, res, req) {
            json = (json.json)[0];
            console.log(json);
            var time = (post.create_time).replace(/[-A-Z:!y]/g, "");
            var invoice_id = post.id + time + json.uid;
            var notes = '\"'+"None"+'\"';
            var payment_status = '\"'+"completed"+'\"';

            var query = util.format(queries.register, json.uid, json.amount, json.discount,
                                post.net_pay, invoice_id, notes, payment_status);
            console.log(query);
/*
            utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
                json = json.json;
                res.send(object);
            });
            */
        });
    });
};

function getTransactionData() {
    //Get data from paypal transaction
}
