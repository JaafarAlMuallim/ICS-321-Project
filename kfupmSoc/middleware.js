module.exports.isLoggedIn = (req, res, next) => {
    if (!req.isAuthenticated()) {
        req.session.returnTo = req.originalUrl
        req.flash("error", "Yout Must Be Signed Up/In");
        return res.redirect("/login");
    }
    next();
}

module.exports.validateTournament = (req, res, next) => {
    const { error } = campgroundSchema.validate(req.body);
    if (error) {
        const msg = error.details.map(el => el.message).join(",");
        throw new AppError(msg, 400)
    } else {
        next();
    }
}
