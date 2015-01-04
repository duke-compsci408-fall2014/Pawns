var mysql = require('mysql');
var utils = require('../utils');
var pbkdf2 = require('pbkdf2-sha256');
var querystring = require('querystring');
var crypto = require('crypto');
var util = require('util');
var queries = require('../queries/login_queries');
var config = require('../config/configuration');
var connectionpool = config.connectionpool;

exports.verifyLogin = function (req, res) {
    var query = 'SELECT username, password FROM auth_user WHERE username=' + '\"' + req.params.user + "\"";
    utils.runQuery(connectionpool, query, req, res, validate);
};

exports.getUser = function (req, res) {
    var query = queries.userViewQuery + '\"' + req.params.user + '\"';
    utils.runQuery(connectionpool, query, req, res, loggedIn);
};

exports.updateUserData = function (req, res) {
    var body = req.body;
    var uri = "";
    for (var key in body) {
        if (body.hasOwnProperty(key) && body[key]!='') {
            uri += key + '=' + '\"' + body[key] + '\"' + ',';
        }
    }
    if (uri) {
        uri = uri.slice(0, -1);
    }
    if (uri) {
        var query = 'UPDATE auth_user SET ' + uri + ' WHERE username=' + '\"' + req.params.user + '\"';
        var innerQuery = queries.userViewQuery + '\"' + req.params.user + '\"';
        utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
            utils.runQuery(connectionpool, innerQuery, req, res, function(json, res, req) {
                var json = (json.json)[0];
                res.send(json);
            });
        });
    }
    else {
        res.send({result:"failure"});
    }
};

exports.createUser = function (req, res) {
    var fields = req.params.fields;
    var parsed = querystring.parse(fields);
    var rawPass = parsed.password.replace(/"/g, '');
    var salt = crypto.randomBytes(8).toString('base64');
    var hashedPass = '\"'+ 'pbkdf2_sha256$10000$' + salt + '$' + pbkdf2(rawPass, new Buffer(salt), 10000, 32).toString('base64') + '\"';
    var query = util.format(queries.insertQuery, parsed.username, parsed.first_name, parsed.last_name, parsed.email, hashedPass, 0, 1, 0);
    utils.runQuery(connectionpool, query, req, res, function(json, res, req) {
        var getID = 'SELECT id from auth_user WHERE username=' + parsed.username;
        utils.runQuery(connectionpool, getID, req, res, function(json, res, req) {
            var uid = (json.json)[0].id;
            var secondInsert = util.format(queries.insertQueryTwo, parsed.username, uid);
            utils.runQuery(connectionpool, secondInsert, req, res, function(json, res, req) {});
        });
        res.send(json);
    });
};

function validate (json, res, req) {
    if (validatePassword(req.params.pass, json.json[0].password)) {
        res.send({verification: 'success'});
        console.log('Success');
    }
    else {
        res.send({verification: 'failure'});
        console.log('Failure');
    }
}

function loggedIn (json, res, req) {
    var json = (json.json)[0];
    var email = json.email;
    var gravatar = crypto.createHash('md5').update(email).digest('hex');
    json.gravatar_hash = gravatar;
    res.send(json);
}

function postInfo (json, res, req) {
    var json = (json.json)[0];
    console.log(json);
    res.send(json);
}

function registerUser (json, res, req) {
    res.send((json.json)[0]);
}

var validatePassword = function (key, string) {
    var parts = string.split('$');
    var iterations = parts[1];
    var salt = parts[2];
    return pbkdf2(key, new Buffer(salt), iterations, 32).toString('base64') === parts[3];
};
