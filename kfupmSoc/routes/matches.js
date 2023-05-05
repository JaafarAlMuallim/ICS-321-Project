const express = require("express");
const router = express.Router();

const matches = require("../controllers/matches");

const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");


// const { isLoggedIn, isAuthor, validateCamp } = require("../middleware");
router.route("/:id")
    .get(wrapAsync(matches.index))

router.route("/:id/goals")
    .get(wrapAsync(matches.editGoals))

router.route("/:id/cards")
    .get(wrapAsync(matches.editCards))

router.route("/:id/subs")
    .get(wrapAsync(matches.editSubs))

router.route("/:id/penalties")
    .get(wrapAsync(matches.editPenalties))

    // .post(wrapAsync())
    // .post(isLoggedIn, upload.array("image"), validateCamp, wrapAsync(camp.createCamp));
module.exports = router;