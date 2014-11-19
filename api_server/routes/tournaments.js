var express = require('express');
var router = express.Router();
var tournaments = require('../controllers/tournaments_controller');

router.route('/all/:id')
	.get(tournaments.getTournament);

router.route('/all')
	.get(tournaments.allTournaments);

module.exports = router;
