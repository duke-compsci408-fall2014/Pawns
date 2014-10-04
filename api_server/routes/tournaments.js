var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });



router.get('/', function(req,res){
    console.log("THIS");
    connectionpool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            var query = 'SELECT name,description,start_date FROM tournament_tournaments WHERE start_date > now()';
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
});

module.exports = router;
