var express = require('express');
var router = express.Router();
var tournaments = require('../controllers/registration_controller');

router.route('/register')
    .post(tournaments.register);

module.exports = router;
