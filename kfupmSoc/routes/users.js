const express = require("express");
const router = express.Router();
// const User = require("../models/user");
const user = require("../controllers/users");

const AppError = require("../utils/error");
const wrapAsync = require("../utils/wrapAsync");

const { isLoggedIn, isAuthor, validateCamp } = require("../middleware");


router.route("/register")
    .get(user.newUser)
    .post(wrapAsync(user.register));

router.route("/login")
    .get(user.renderLogin)
    .post(wrapAsync(user.userLogin));

router.route('/requests')
    .get(isLoggedIn ,wrapAsync(user.renderRequests))

router.route('/approve/:id')
    .post(isLoggedIn,wrapAsync(user.approvedMember));
router.route('/decline/:id')
    .post(isLoggedIn,wrapAsync(user.declineMember))
router.get('/logout', user.logout);

module.exports = router;