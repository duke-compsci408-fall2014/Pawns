var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });



router.get('/base', function(req,res){
    var query = 'SELECT name,description,start_date FROM tournament_tournaments WHERE start_date > now() ORDER BY start_date ASC';
    runQuery(connectionpool, query, req, res, doStuff);
});

function doStuff(res) {
    console.log(res);
}

router.get('/base/:id', function(req, res) {
    var query = 'SELECT name, description, amount, cash_prize, discount, status, start_date, end_date FROM tournament_tournaments WHERE id=' + req.params.id;
    runQuery(connectionpool, query, req, res, doStuff);
});


var runQuery = function (connectionPool, sqlQuery, req, res, callback) {
    connectionPool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            var query = sqlQuery; //'SELECT name,description,start_date FROM tournament_tournaments WHERE start_date > now()';
            console.log(query);
            connection.query(query, req.params.id, function(err, rows, fields) {

                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err:    err.code
                    });
                }
                else {
                    callback({json: rows});
                    res.send({
                        result: 'success',
                        err:    '',
                        fields: fields,
                        json:   rows,
                        length: rows.length
                    });
                }
                connection.release();
            });
        }
    });
}

module.exports = router;
