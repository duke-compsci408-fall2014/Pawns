exports.runQuery = function (connectionPool, sqlQuery, req, res, callback) {
    connectionPool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            var query = sqlQuery;
            console.log(query);
            connection.query(query, function(err, rows, fields) {

                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err:    err.code
                    });
                }
                else {
                    callback({json: rows}, res, req);
                    /*res.send({
                        result: 'success',
                        err:    '',
                        fields: fields,
                        json:   rows,
                        length: rows.length
                    });*/
                }
                connection.release();
            });
        }
    });
}
