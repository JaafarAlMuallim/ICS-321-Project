// const Campground = require("../models/campground");

if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');


const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);




module.exports.index = async (req, res) => {
    // const tournaments = await Tournament.find();
    const find = await supabase.from('tournament').select();
    const tournaments = find.data;
    // const tournaments = null
    res.render("tournaments/index", { tournaments })
}

module.exports.new = (req, res) => {
    res.render("tournaments/new")
}

module.exports.createTournament = async (req, res, next) => {

    // const geoData = await geocoder.forwardGeocode({
    //     query: req.body.campground.location,
    //     limit: 1
    // }).send();
    // const camp = new Campground(req.body.campground);
    // camp.geometry = geoData.body.features[0].geometry;
    // camp.images = req.files.map(file => ({ url: file.path, filename: file.filename }));
    // camp.author = req.user._id;
    // await camp.save();
    // req.flash("success", "Successfully Added The Camp");
    // res.redirect(`campgrounds/${camp._id}`);
}
module.exports.showTournament = async (req, res, next) => {
    const teams = await supabase.from('team').select('team_uuid').eq('tr_id', req.params.id);
    const teamsArr = []
    for (let i = 0; i < teams.data.length; i++) {
        teamsArr.push(teams.data[i].team_uuid)
    }
    const players = await supabase.from('player').select().in('team_tr', teamsArr);
    const playersArr = []
    for (let i = 0; i < players.data.length; i++) {
        playersArr.push(players.data[i].player_uuid)
    }
    const playersData = players.data;

    const referee = await supabase.from('referee').select();
    const refereeData = referee.data;

    const venue = await supabase.from('venue').select();
    const venueData = venue.data;

    const matches = await supabase.from('match_details').select().in('player_gk', playersArr);
    const matchArr = []
    for (let i = 0; i < matches.data.length; i++) {
        matchArr.push(matches.data[i].match_no)
    }
    const matchesPlayed = await supabase.from('match_played').select().in('match_no', matchArr);
    const played = matchesPlayed.data
    console.log(refereeData)
    const tournamentID = req.params.id;
    if(!played){
        req.flash("error", "Cannot Find That Tournament!");
        return res.redirect("/tournaments");
    }
    res.render("tournaments/show", {played, playersData, refereeData, venueData, tournamentID});
}

module.exports.deleteTournament = async (req, res, next) => {
    // const deleted = await Campground.findByIdAndDelete(req.params.id);
    // req.flash("success", "Successfully Deleted The Camp");
    // res.redirect("/campgrounds");
}
module.exports.editTournament = async (req, res, next) => {
    // const camp = await Campground.findById(req.params.id);

    // if (!camp) {
    //     req.flash("error", "Cannot Find That Campground");
    //     return res.redirect("/campgrounds")
    // }
    // res.render("campgrounds/edit", { camp })
}
module.exports.updateTournament = async (req, res, next) => {
    // if (!req.body.campground) throw new AppError("Invalid Data", 400);
    // const { id } = req.params;
    // console.log(req.body);
    // const camp = await Campground.findByIdAndUpdate(id, req.body.campground, { runValidators: true });
    // const imgs = req.files.map(file => ({ url: file.path, filename: file.filename }));
    // camp.images.push(...imgs);
    // await camp.save();

    // if (req.body.deleteImages.length) {
    //     for (let filename of req.body.deleteImages) {
    //         await cloudinary.uploader.destroy(filename);
    //     }
    //     await camp.updateOne({ $pull: { images: { filename: { $in: req.body.deleteImages } } } });
    // }
    // req.flash("success", "Successfully Updated The Camp");
    // res.redirect(`/campgrounds/${id}`);
}