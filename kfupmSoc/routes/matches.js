const express = require("express");
const router = express.Router();

const matches = require("../controllers/matches");

const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");
const { isLoggedIn, isAdmin } = require("../middleware");


// const { isLoggedIn, isAuthor, validateCamp } = require("../middleware");
router.route("/:id")
    .get(wrapAsync(matches.index))

router.route("/:id/goals")
    .get(wrapAsync(matches.editGoals))
    // .post(isLoggedIn, isAdmin, wrapAsync(matches.updateGoals))
    .post(wrapAsync(matches.updateGoals))
    
    router.route("/:id/cards")
    .get(wrapAsync(matches.editCards))
    // .post(isLoggedIn, isAdmin, wrapAsync(matches.updateCards))
    .post(wrapAsync(matches.updateCards))

    
    router.route("/:id/subs")
    .get(wrapAsync(matches.editSubs))
    // .post(isLoggedIn, isAdmin, wrapAsync(matches.updateSubs))
    .post(wrapAsync(matches.updateSubs))
    
    router.route("/:id/penalties")
    .get(wrapAsync(matches.editPenalties))
    // .post(isLoggedIn, isAdmin, wrapAsync(matches.updatePenalties))
    .post(wrapAsync(matches.updatePenalties))

    router.route("/:id/audience")
    .get(wrapAsync(matches.editAudience))
    // .post(isLoggedIn, isAdmin, wrapAsync(matches.updateAudience))
    .post(wrapAsync(matches.updateAudience))

    router.route("/:id/mvp/:id")
        // .post(isLoggedIn, isAdmin, wrapAsync(matches.updateMvp))
        .post(wrapAsync(matches.updateMvp))
    // .post(wrapAsync())
    // .post(isLoggedIn, upload.array("image"), validateCamp, wrapAsync(camp.createCamp));
module.exports = router;