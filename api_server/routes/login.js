var express = require('express');
var router = express.Router();
var login = require('../controllers/login_controller');

router.route('/verify/:user/:pass')
	.get(login.verifyLogin);

router.route('/:user')
	.get(login.getUser);

router.route('/update/:user')
	.put(login.updateUserData);

router.route('/register/:fields')
	.post(login.createUser);

module.exports = router;
