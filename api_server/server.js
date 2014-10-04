var express = require('express'),
    app     = express(),
    mysql   = require('mysql'),
    connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });
/*
app.get('/:table', function(req,res){
    connectionpool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            connection.query('SELECT * FROM '+req.params.table, req.params.id, function(err, rows, fields) {
                //console.log(rows);
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
*/

app.get('/login/:user', function(req,res){
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

app.get('/tournaments', function(req,res){
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

app.get('/:table/:id', function(req,res){});
app.post('/:table', function(req,res){});
app.put('/:table/:id', function(req,res){});
app.delete('/:table/:id', function(req,res){});
app.listen(3000);
console.log('Rest Server Listening on port 3000');
