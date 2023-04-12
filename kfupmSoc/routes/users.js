const express = require("express");
const router = express.Router();
// const passport = require("passport");
// const User = require("../models/user");
const user = require("../controllers/users");

const AppError = require("../utils/error");
const wrapAsync = require("../utils/wrapAsync");


router.route("/register")
    .get(user.newUser)
    // .post(wrapAsync(user.register));

router.route("/login")
    .get(user.renderLogin)
    // .post(passport.authenticate('local', { failureFlash: true, failureRedirect: '/login', keepSessionInfo: true }), user.userLogin)

router.get('/logout', user.logout);

module.exports = router;