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
                    callback({json: rows}, req);
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

exports.runQuery = runQuery;
