const express = require("express");
const router = express.Router();

const tournaments = require("../controllers/tournaments");
const { isLoggedIn, validateTournament } = require("../middleware");
const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");

router.route("/")
    .get(wrapAsync(tournaments.index))
    .post(isLoggedIn, validateTournament, wrapAsync(tournaments.createTournament));

router.get("/new", isLoggedIn, tournaments.new);

router.route("/:id")
    .get(wrapAsync(tournaments.showTournament))
    .delete(isLoggedIn, wrapAsync(tournaments.deleteTournament))
    .put(isLoggedIn, validateTournament, wrapAsync(tournaments.update));

router.get("/:id/edit", isLoggedIn, wrapAsync(tournaments.edit));
module.exports = router;