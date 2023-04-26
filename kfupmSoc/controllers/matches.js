// const Campground = require("../models/campground");
// const mbxGeocoding = require("@mapbox/mapbox-sdk/services/geocoding")
// const mapboxToken = process.env.MAPBOX_TOKEN;
// const geocoder = mbxGeocoding({ accessToken: mapboxToken });
// const { cloudinary } = require("../cloudinary");

if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');
const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

module.exports.index = async (req, res) => {
    const {id} = req.params;

    const { data: matches, errorMatches } = await supabase.from('match_details').select(`
    *
    `).eq('match_uuid', id);
    const teamIds = [matches[0].team_one, matches[0].team_two]; 

    // get teams from teamIds
    const { data: teams, errorTeams } = await supabase.from('team').select(`
    *, registered_team (*)`).in('team_uuid', teamIds).order('team_id', {ascending: true})

    const { data: coaches, error } = await supabase.from('team_coach').select(`
        *, 
        member ( * )
        `).in('team_uuid', teamIds);

    const {data: captains, errorCaptain} = await supabase
        .from('team_captain')
        .select(`*, member(*, player(*, registered_team(*, team(*))))`)
        .in('team_uuid', teamIds);
    
    const {data: subs, errorSub} = await supabase
        .from('player_in_out')
        .select(`*, member(*, player(*, registered_team(*, team(*))))`)
        .eq('match_no', id);

    const {data: goals, errorGoal} = await supabase
        .from('goal_details')
        .select(`*, member(*, player(*, registered_team(*, team(*))))`)
        .eq('match_no', id).order('goal_time', {ascending: true});

    const {data: cards, errorCard} = await supabase
        .from('player_booked').
        select(`*, member(*, player(*, registered_team(*, team(*))))`)
        .eq('match_no', id);
        
        const goalsArray = [];
        goals.forEach(goal => {
        if (goal.member.player[0].registered_team.team_uuid == teams[0].team_uuid && goal.member.player[0].registered_team.team[0].tr_id == teams[0].tr_id) {
            goalsArray.push(goal);
        } else if (goal.member.player[0].registered_team.team_uuid == teams[1].team_uuid && goal.member.player[0].registered_team.team[0].tr_id == teams[1].tr_id) {
            goalsArray.push(goal);
        }
        });
       const cardsArray = []
         cards.forEach(card => {
            if (card.member.player[0].registered_team.team_uuid == teams[0].team_uuid && card.member.player[0].registered_team.team[0].tr_id == teams[0].tr_id) {
                cardsArray.push(card);
            } else if (card.member.player[0].registered_team.team_uuid == teams[1].team_uuid && card.member.player[0].registered_team.team[0].tr_id == teams[1].tr_id) {
                cardsArray.push(card);
            }});

        const {data: penaltyShootout, errorPenaltyShootout} = await supabase
        .from('penalty_shootout')
        .select(`*,
        member( *, player(*, registered_team(*, team(*))))`)
        .eq('match_no', id);

        // create subsArray
        const subsArray = [];
        subs.forEach(sub => {
            if (sub.member.player[0].registered_team.team_uuid == teams[0].team_uuid && sub.member.player[0].registered_team.team[0].tr_id == teams[0].tr_id) {
                subsArray.push(sub);
            } else if (sub.member.player[0].registered_team.team_uuid == teams[1].team_uuid && sub.member.player[0].registered_team.team[0].tr_id == teams[1].tr_id) {
                subsArray.push(sub);
            }
        });
        // create penaltiesArray
        const penaltiesArray = [];
        penaltyShootout.forEach(penalty => {
            if (penalty.member.player[0].registered_team.team_uuid == teams[0].team_uuid && penalty.member.player[0].registered_team.team[0].tr_id == teams[0].tr_id) {
                penaltiesArray.push(penalty);
            } else if (penalty.member.player[0].registered_team.team_uuid == teams[1].team_uuid && penalty.member.player[0].registered_team.team[0].tr_id == teams[1].tr_id) {
                penaltiesArray.push(penalty);
            }
        });
        res.render("matches/index", {teams, coaches, captains, subsArray, goalsArray, cardsArray, penaltiesArray});
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
// TODO FINISH IT
module.exports.showTournament = async (req, res, next) => {

    // const match = await 
    // const camp = await Campground.findById(req.params.id).populate({
    //     path: "reviews",
    //     populate: "author",
    // }).populate("author");
    // if (!camp) {
    //     req.flash("error", "Cannot Find That Campground");
    //     return res.redirect("/campgrounds")
    // }
    // res.render("campgrounds/show", { camp })
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