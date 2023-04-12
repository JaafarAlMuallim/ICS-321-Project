// const User = require("../models/user");

module.exports.newUser = (req, res) => {
    res.render("users/register");
}

module.exports.register = async (req, res) => {
    try {
        const { username, password, email } = req.body;
        const user = new User({ email, username });
        const newUser = await User.register(user, password);
        req.login(newUser, err => {
            if (err) return next(err);
            req.flash("success", "Welcome To Yelp Camp!");
            res.redirect("/campgrounds");
        });
    } catch (e) {
        req.flash("error", e.message);
        res.redirect("/register");
    }
}

module.exports.renderLogin = (req, res) => {
    res.render("users/login");
}
module.exports.userLogin = (req, res) => {
    req.flash("success", "Welcome Back!");
    const url = req.session.returnTo || "/campgrounds";
    delete req.session.returnTo;
    res.redirect(url);
}
module.exports.logout = (req, res) => {
    req.logout((err) => {
        if (err) { return next(err); }
        req.flash("success", "See You Next Time");
        res.redirect('/campgrounds');
    });
}