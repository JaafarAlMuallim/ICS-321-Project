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
    // const tournaments = await Tournament.find();
    const {id} = req.params;

    // join match and team table on player_gk
    const { data: matches, errorMatches } = await supabase.from('match_details').select(`
    match_no, goal_score, penalty_score, asst_ref, player_gk,
    player( player_uuid, player_id, team_tr, jersey_no, player_name, position_to_play, 
        team( team_uuid, team_id, tr_id, team_group, won, draw, lost, goal_for, goal_against, goal_diff, points, group_position )),
    asst_ref( asst_ref_id, asst_ref_name)
    `).eq('match_no', id);
    const teamIds = [matches[0].player.team.team_uuid, matches[1].player.team.team_uuid]; 
    
    const teamOne = matches[0];
    const teamTwo = matches[1];
    const { data: coaches, error } = await supabase.from('team_coaches').select(`
    team_tr, coach_id, 
    coach ( coach_id, coach_name )
    `).in('team_tr', teamIds)

    // get Captains
    const {data: captains, errorCaptain} = await supabase
        .from('match_captain')
        .select(`match_no, player_captain,
            player( player_uuid, player_id, team_tr, jersey_no, player_name, position_to_play, 
                team( team_uuid, team_id, tr_id, team_group ))`)
        .eq('match_no', id);

    const {data: matchPlayed, errorPlayerOfMatch} = await supabase
        .from('match_played')
        .select(`*, player:player_uuid (*)`)
        .eq('match_no', id);

    const {data: subs, errorSub} = await supabase
        .from('player_in_out').select(`match_no, player_id, in_out, time_in_out, play_schedule, play_half,
        player( player_uuid, player_id, team_tr, jersey_no, player_name, position_to_play, 
            team( team_uuid, team_id, tr_id, team_group )
        )`)
        .eq('match_no', id);

    const {data: goals, errorGoal} = await supabase
        .from('goal_details').select(`match_no, player_id, goal_time, goal_half, goal_schedule,
        player( player_uuid, player_id, team_tr, jersey_no, player_name, position_to_play, 
            team( team_uuid, team_id, tr_id, team_group)
        )`)
        .eq('match_no', id).order('goal_time', { ascending: true });

    const {data: cards, errorCard} = await supabase
        .from('player_booked').
        select(`match_no, player_id, booking_time, sent_off, play_schedule, play_half, 
        player( player_uuid, player_id, team_tr, jersey_no, player_name, position_to_play,
            team( team_uuid, team_id, tr_id, team_group)
        )`)
        .eq('match_no', id);
        
            // create array that contains goals scored by both teamOne and teamTwo only in the same array
    const goalsArray = [];
    goals.forEach(goal => {
        if (goal.player.team.team_uuid == teamOne.player.team.team_uuid && teamOne.player.team.team_uuid == goal.player.team.team_uuid && goal.player.team_tr == teamOne.player.team_tr) {
            goalsArray.push(goal);
        } else if (goal.player.team.team_uuid == teamTwo.player.team.team_uuid && teamTwo.player.team.team_uuid == goal.player.team.team_uuid && goal.player.team_tr == teamTwo.player.team_tr) {
            goalsArray.push(goal);
        }
    });
       const cardsArray = []
         cards.forEach(card => {
            if (card.player.team.team_uuid == teamOne.player.team.team_uuid && teamOne.player.team.team_uuid == card.player.team.team_uuid && card.player.team_tr == teamOne.player.team_tr) {
                cardsArray.push(card);
            } else if (card.player.team.team_uuid == teamTwo.player.team.team_uuid && teamTwo.player.team.team_uuid == card.player.team.team_uuid && card.player.team_tr == teamTwo.player.team_tr) {
                cardsArray.push(card);
            }});

        const {data: penaltyShootout, errorPenaltyShootout} = await supabase
        .from('penalty_shootout')
        .select(`match_no, player_id, score_goal, kick_no,
        player( player_uuid, player_id, team_tr, jersey_no, player_name, position_to_play,
            team( team_uuid, team_id, tr_id, team_group)
        )`)
        .eq('match_no', id);
        res.render("matches/index", {teamOne, teamTwo, coaches, captains, matchPlayed, subs, goalsArray, cardsArray, penaltyShootout});
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