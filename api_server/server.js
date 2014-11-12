var express = require('express'),
    tournaments = require('./routes/tournaments'),
    login = require('./routes/login'),
    users = require('./routes/users'),
    app     = express(),
    mysql   = require('mysql'),
    connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : process.env.BACKUP,
        database : 'backup'
    });

app.use('/api/v1/tournaments', tournaments);
app.use('/api/v1/login', login);
app.use('/api/v1/users', users);

/*
app.get('/:table/:id', function(req,res){});
app.post('/:table', function(req,res){});
app.put('/:table/:id', function(req,res){});
app.delete('/:table/:id', function(req,res){});
*/

app.listen(3000);
console.log('REST Server Listening on port 3000');
module.exports = app;
