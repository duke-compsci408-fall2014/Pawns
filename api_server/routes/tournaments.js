var express = require('express');
var router = express.Router();
var tournaments = require('../controllers/tournaments_controller');

router.route('/general')
    .get(tournaments.generalTournaments);

router.route('/general/:id')
	.get(tournaments.specificTournament);

module.exports = router;
