const express = require("express");
const router = express.Router();
// const User = require("../models/user");
const user = require("../controllers/users");

const AppError = require("../utils/error");
const wrapAsync = require("../utils/wrapAsync");


router.route("/register")
    .get(user.newUser)
    .post(wrapAsync(user.register));

router.route("/login")
    .get(user.renderLogin)
    .post(wrapAsync(user.userLogin));

router.route('/requests')
    .get(wrapAsync(user.renderRequests))

router.route('/approve/:id')
    .post(wrapAsync(user.approved));
router.route('/decline/:id')
    .post(wrapAsync(user.decline))
router.get('/logout', user.logout);

module.exports = router;