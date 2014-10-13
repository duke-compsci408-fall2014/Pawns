var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var utils = require('../utils');
var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });

router.get('/:id', function (req, res) {
    var query = 'SELECT username, firstname, lastname, email, date_joined
                FROM auth_user WHERE ' + req.params.id;
    utils.runQuery(connectionpool, query, req, res, callback);
});

function callback (res) {
    console.log(res);
}

module.exports = router;
