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



router.get('/base', function(req,res){
    var query = 'SELECT name,description,start_date,id FROM tournament_tournaments WHERE start_date > now() ORDER BY start_date ASC';
    utils.runQuery(connectionpool, query, req, res, doStuff);
});

function doStuff(res) {
    console.log(res);
}

router.get('/base/:id', function(req, res) {
    var query = 'SELECT name, description, amount, cash_prize, discount, status, start_date, end_date FROM tournament_tournaments WHERE id=' + req.params.id;
    utils.runQuery(connectionpool, query, req, res, doStuff);
});

module.exports = router;
