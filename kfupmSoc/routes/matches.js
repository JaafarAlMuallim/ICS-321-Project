const express = require("express");
const router = express.Router();

const tournaments = require("../controllers/tournaments");
// const Campground = require("../models/campground");

const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");

// const multer = require("multer");
// const { storage } = require("../cloudinary")
// const upload = multer({ storage: storage })

// const { isLoggedIn, isAuthor, validateCamp } = require("../middleware");
// TODO POST
router.route("/")
    .get(wrapAsync(tournaments.index))
    // .post(isLoggedIn, upload.array("image"), validateCamp, wrapAsync(camp.createCamp));
// .post(upload.array("image"), (req, res) => {
//     console.log(req.body, req.files);
//     res.send("NOICE???");
// });
// TODO GET WITH LOGGED IN
// router.get("/new", isLoggedIn, tournament.new);
router.get("/new", tournaments.new);

router.route("/:id")
    .get(wrapAsync(tournaments.showTournament))
    // .delete(isLoggedIn, isAuthor, wrapAsync(camp.deleteCamp))
    // .put(isLoggedIn, isAuthor, upload.array("image"), validateCamp, wrapAsync(camp.update));

// TODO EDIT PAGE
// router.get("/:id/edit", isLoggedIn, isAuthor, wrapAsync(camp.edit));
router.get("/:id/matches")
module.exports = router;