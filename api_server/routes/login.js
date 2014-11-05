var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var pbkdf2 = require('pbkdf2-sha256');
var querystring = require('querystring');

var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });


var userViewQuery = 'SELECT auth_user.username, auth_user.first_name, auth_user.last_name, \
                        auth_user.email, auth_user.password, auth_user.date_joined, \
                        player_accounts_playerprofile.uscf_id, player_accounts_playerprofile.main_phone, \
                        player_accounts_playerprofile.address, player_accounts_playerprofile.city, player_accounts_playerprofile.state \
                    FROM auth_user \
                    INNER JOIN player_accounts_playerprofile ON auth_user.id=player_accounts_playerprofile .user_id \
                    WHERE auth_user.username=';


router.get('/verify/:user/:pass', function (req, res) {
    var query = 'SELECT username, password FROM auth_user WHERE username=' + '\"' + req.params.user + "\"";
    utils.runQuery(connectionpool, query, req, res, validate);
});

router.get('/:user', function (req, res) {
    var query = userViewQuery + '\"' + req.params.user + '\"';
    utils.runQuery(connectionpool, query, req, res, loggedIn);
});

router.post('/update/:user/:fields', function (req, res) {
    var fields = req.params.fields;

    var result = fields.split("&");

    var uri = "";

    for (var i=0; i<result.length; i++) {
        var value = (result[i]).split("=");
        var str = (value[1]).replace(/"/g,'');
        if (str) {
            uri += value[0] + '=' + value[1] + ',';
        }
    }
    if (uri) {
        uri = uri.slice(0, -1);
    }
    console.log(uri.length);
    if (uri) {
        var query = 'UPDATE auth_user SET ' + uri + ' WHERE username=' + '\"' + req.params.user + '\"';
        utils.runQuery(connectionpool, query, req, res, postInfo);
    }
    else {
        res.send({result:"failure"});
    }
});

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
    res.send(json);
}

function postInfo (json, res, req) {
    res.send(json);
}

var validatePassword = function (key, string) {
        var parts = string.split('$');
        var iterations = parts[1];
        var salt = parts[2];
        return pbkdf2(key, new Buffer(salt), iterations, 32).toString('base64') === parts[3];
};

module.exports = router;
