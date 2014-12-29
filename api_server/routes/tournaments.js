var express = require('express');
var router = express.Router();
var tournaments = require('../controllers/tournaments_controller');

router.route('/general')
    .get(tournaments.generalTournaments);

router.route('/group/:gid')
	.get(tournaments.groupedTournaments);

router.route('/group/:gid/:id')
	.get(tournaments.specificTournament);

module.exports = router;
