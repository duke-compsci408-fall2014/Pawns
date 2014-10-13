var express = require('express'),
    tournaments = require('./routes/tournaments'),
    app     = express(),
    mysql   = require('mysql'),
    connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });

router.get('/:user', function(req,res){
    connectionpool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            var query = 'SELECT * FROM auth_user WHERE username=' + "\"" + req.params.user + "\"";
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
                    //console.log(rows.length);
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
