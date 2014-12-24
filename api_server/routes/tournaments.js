var express = require('express');
var router = express.Router();
var tournaments = require('../controllers/tournaments_controller');

router.route('/group/:gid/:id')
	.get(tournaments.specificTournament);

router.route('/group/:gid')
	.get(tournaments.groupedTournaments);

router.route('/general')
    .get(tournaments.generalTournamnets);

module.exports = router;
