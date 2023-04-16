const express = require("express");
const router = express.Router();

const tournaments = require("../controllers/tournaments");
const { isLoggedIn, validateTournament, isAdmin } = require("../middleware");
const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");

router.route("/")
    .get(wrapAsync(tournaments.index))
    .post(isLoggedIn, validateTournament, wrapAsync(tournaments.createTournament));

router.get("/new", isLoggedIn, tournaments.new);

router.route("/:id")
    .get(wrapAsync(tournaments.showTournament))
    .put(isLoggedIn, validateTournament, wrapAsync(tournaments.updateTournament))
    .delete(isLoggedIn, isAdmin, wrapAsync(tournaments.deleteTournament));

router.get("/:id/edit", isLoggedIn, isAdmin, wrapAsync(tournaments.editTournament));
module.exports = router;