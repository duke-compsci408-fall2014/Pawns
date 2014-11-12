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

var baseQuery =
'SELECT * FROM `tournament_events` te \
    INNER JOIN tournament_tournaments tt \
ON te.`tournaments_id` = tt.id \
INNER JOIN membership_categorytype \
WHERE tt.category_type_id = 2 \
AND te.date_play > NOW() ORDER BY `te`.`date_play`  ASC \
limit 0, 100';

var queryString =
'SELECT tournament_events.date_play, \
    tournament_events.start_time, \
    tournament_events.end_time, \
    tournament_events.round_times, \
    tournament_sites.name, \
    tournament_sites.description, \
    tournament_sites.address, \
    tournament_sites.city, \
    tournament_sites.state, \
    tournament_sites.zip, \
    tournament_sections.name, \
    tournament_sections.rating_min, \
    tournament_sections.rating_max, \
    tournament_sections.grade_min, \
    tournament_sections.grade_max, \
    tournament_sections.rounds, \
    tournament_sections.prizes, \
    tournament_sections.prize_team \
FROM \
    tournament_sites \
INNER JOIN tournament_events ON tournament_events.sites_id=tournament_sites.id \
INNER JOIN tournament_sections ON tournament_sections.id=tournament_events.sections_id \
WHERE tournament_events.id=';

router.get('/base', function(req,res){
    var query = 'SELECT name,description,start_date,id FROM tournament_tournaments WHERE start_date > now() ORDER BY start_date ASC';
    //var query = baseQuery;
    utils.runQuery(connectionpool, query, req, res, doStuff);
});

function doStuff(json, res, req) {
    res.send(json);
    /*res.send({
        result: 'success',
        err:    '',
        fields: fields,
        json:   rows,
        length: rows.length
    });*/
}

router.get('/base/:id', function(req, res) {
    // var query = 'SELECT name, description, amount, cash_prize, discount, status, start_date, end_date FROM tournament_tournaments WHERE id=' + req.params.id;
    var query = queryString + req.params.id;
    utils.runQuery(connectionpool, query, req, res, doStuff);
});

module.exports = router;
