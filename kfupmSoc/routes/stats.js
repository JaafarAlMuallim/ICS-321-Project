const express = require("express");
const router = express.Router();

const matches = require("../controllers/stats");

const wrapAsync = require("../utils/wrapAsync");
const AppError = require("../utils/error");


router.route("/")
    .get(wrapAsync(matches.index))
    
module.exports = router;