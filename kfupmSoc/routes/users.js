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

router.route('/requests/:id')
    .post(wrapAsync(user.approved))
    .post(wrapAsync(user.decline))
router.get('/logout', user.logout);

module.exports = router;