const {tournamentSchema} = require('./schemas');
const AppError = require("./utils/error");

// require supabase 
const { createClient } = require('@supabase/supabase-js');
// require dotenv
const dotenv = require('dotenv');
dotenv.config();
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

module.exports.isLoggedIn = (req, res, next) => {
    if (!req.session.user) {
        req.session.returnTo = req.originalUrl
        req.flash("error", "Yout Must Be Signed Up/In");
        return res.redirect("/login");
    }
    next();
}

module.exports.validateTournament = (req, res, next) => {
    const { error } = tournamentSchema.validate(req.body);
    if (error) {
        const msg = error.details.map(el => el.message).join(",");
        throw new AppError(msg, 400)
    } else {
        next();
    }
}

module.exports.isAdmin = async (req, res, next) => {
    const { id } = req.params;

    const { data: tournament, error } = await supabase
        .from('tournament')
        .select('*')
        .eq('tr_id', id);
    if (tournament[0].adminstrator != req.session.user.admin_id) {
        req.flash("error", "You Do Not Have Premission To Do That");
        return res.redirect(`/tournaments/${id}`)
    }
    next();
}