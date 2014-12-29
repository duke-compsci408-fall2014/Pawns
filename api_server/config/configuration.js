var mysql = require('mysql');
var connectionpool = mysql.createPool({
    host     : 'localhost',
    user     : 'root',
    password : process.env.BACKUP,
    database : 'backup'
});

exports.connectionpool = connectionpool;
