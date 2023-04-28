const express = require("express");
const router = express.Router();

const teams = require("../controllers/teams");

const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");


// const { isLoggedIn, isAuthor, validateCamp } = require("../middleware");
router.route("/")
    .get(wrapAsync(teams.allTeams));
router.route("/:id")
    .get(wrapAsync(teams.index))

router.route("/:id/changeCaptain/:id").post(wrapAsync(teams.changeCaptain));
router.route("/:id/changeManager/:id").post(wrapAsync(teams.changeManager));
router.route("/:id/changeCoach/:id").post(wrapAsync(teams.changeCoach));

router.route("/:id/approve/:id")
    .post(wrapAsync(teams.approveTeam))
router.route("/:id/decline/:id")
    .post(wrapAsync(teams.declineTeam))
module.exports = router;