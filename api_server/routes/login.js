var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var pbkdf2 = require('pbkdf2-sha256');

var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });

router.get('/verify/:user/:pass', function (req, res) {
    var query = 'SELECT username, password FROM auth_user WHERE username=' + '\"' + req.params.user + "\"";
    utils.runQuery(connectionpool, query, req, res, validate);
});

router.get('/:user', function (req, res) {
    var query = 'SELECT * FROM auth_user WHERE username=' + '\"' + req.params.user + '\"';
    utils.runQuery(connectionpool, query, req, res, loggedIn);
});

router.post('/update/:user/:field/:newvalue', function (req, res) {
    var query = 'UPDATE auth_user SET ' + req.params.field + '=' + '\"' + req.params.newvalue + '\"' + ' WHERE username='+'\"' + req.params.user + '\"';
    utils.runQuery(connectionpool, query, req, res, postInfo);
});

function loggedIn (json, res, req) {
    res.send(json);
}

function postInfo (json, res, req) {
    res.send(json);
}

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

var validatePassword = function (key, string) {
        var parts = string.split('$');
        var iterations = parts[1];
        var salt = parts[2];
        return pbkdf2(key, new Buffer(salt), iterations, 32).toString('base64') === parts[3];
};

module.exports = router;
