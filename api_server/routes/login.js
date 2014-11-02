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

router.get('/:user/:pass', function (req, res) {
    var query = 'SELECT * FROM auth_user WHERE username=' + '\"' + req.params.user + "\"";
    utils.runQuery(connectionpool, query, req, res, validate);
});


function validate (res, req) {
    if (validatePassword(req.params.pass, res.json[0].password)) {
        console.log('Success');
    }
    else {
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
