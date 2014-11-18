var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var util = require('util');
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

        var user_id = 0;
        var total_fee = 0;
        var discount = 0;
        var net_pay = 0;
        var invoice_id = 0;
        var notes = "None";
        var payment_status = "completed";

        var query = util.format(queries.register, user_id, total_fee, discount,
                            net_pay, invoice_id, notes, payment_status);

        console.log(query);
        /*
        utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
            json = json.json;
            console.log(json);
            console.log(object);
            res.send(object);
        });
        */
    });
};
