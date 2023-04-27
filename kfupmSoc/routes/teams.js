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

router.route("/:id/changeCaptain/:id").post(wrapAsync(teams.changeCaptain))

router.route("/:id/approve/:id")
    .post(wrapAsync(teams.approveTeam))
router.route("/:id/decline/:id")
    .post(wrapAsync(teams.declineTeam))

    // .post(isLoggedIn, upload.array("image"), validateCamp, wrapAsync(camp.createCamp));
// .post(upload.array("image"), (req, res) => {
//     console.log(req.body, req.files);
//     res.send("NOICE???");
// });
// TODO GET WITH LOGGED IN
// router.get("/new", isLoggedIn, tournament.new);
// router.get("/tournaments/:id/matches/new", matches.new);
module.exports = router;