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
        .eq('booking_time', id);
        
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



module.exports.editMatchStats = async (req, res, next) => {
    const { id } = req.params;

    const { data: matches, error } = await supabase
        .from('match_played')
        .select('*').eq('match_uuid',id);
        ;
    if (error) {
        req.flash("error", error.message);
        res.redirect("/tournaments");
        return;
    }
    const match = match[0]
    res.render('matches/edit', { match });
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

module.exports.editGoals = async (req, res, next) => {
    const {id} = req.params;

    const {data: teams, error} = await supabase
        .from('match_details')
        .select(`*`).eq('match_uuid', id);

      // put the teams uuids in an array
      const teamsUuids = [teams[0].team_one, teams[0].team_two];
      // get the playersData of the teams
      const {data: playersData, errorPlayers} = await supabase
          .from('player')
          .select(`*, team:team_uuid(*), registered_team:team_uuid(*), member:member_uuid(*)`).in('team_uuid', teamsUuids);  
    
    res.render('matches/editGoals', {teams, playersData});
}
module.exports.editCards = async (req, res, next) => {
    const {id} = req.params;

    const {data: teams, error} = await supabase
        .from('match_details')
        .select(`*`).eq('match_uuid', id);


      // put the teams uuids in an array
      const teamsUuids = [teams[0].team_one, teams[0].team_two];
      // get the playersData of the teams
      const {data: playersData, errorPlayers} = await supabase
          .from('player')
          .select(`*, team:team_uuid(*), registered_team:team_uuid(*), member:member_uuid(*)`).in('team_uuid', teamsUuids);  

    res.render('matches/editCards', {teams, playersData});
}

module.exports.editSubs = async (req, res, next) => {
    const {id} = req.params;

    const {data: teams, error} = await supabase
        .from('match_details')
        .select(`*`).eq('match_uuid', id);

    // put the teams uuids in an array
    const teamsUuids = [teams[0].team_one, teams[0].team_two];
    // get the playersData of the teams
    const {data: playersData, errorPlayers} = await supabase
    .from('player')
    .select(`*, team:team_uuid(*), registered_team:team_uuid(*), member:member_uuid(*)`).in('team_uuid', teamsUuids);  


    res.render('matches/editSubs', {teams, playersData});
}

module.exports.editPenalties = async (req, res, next) => {
    const {id} = req.params;

    // get the tournament id from url
    const tournamentId = req.originalUrl.split('/')[2];
    // get the tournament data
    const {data: tournament, trError} = await supabase.from('tournament').select().eq('tr_id', tournamentId);

    // get the match from the id
    const {data: match, matchError} = await supabase
        .from('match_played')
        .select('*').eq('match_uuid',id);
    const {data: teams, error} = await supabase
        .from('match_details')
        .select(`*`).eq('match_uuid', id);

    // put the teams uuids in an array
    const teamsUuids = [teams[0].team_one, teams[0].team_two];
    // get the playersData of the teams
    const {data: playersData, errorPlayers} = await supabase
    .from('player')
    .select(`*, team:team_uuid(*), registered_team:team_uuid(*), member:member_uuid(*)`).in('team_uuid', teamsUuids);  

    res.render('matches/editPenalties', {teams, playersData, tournament, match});
}

module.exports.updatePenalties = async (req, res, next) =>{
    const {id} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];

    // get the penalties with the id
    const {data: penalties, error} = await supabase
        .from('penalty_shootout')
        .select(`*`).eq('match_no', id);

    const counter = penalties ? penalties.length : 0;
    const goalkeeperId = req.body.goalkeeper;
    const scorerId = req.body.scorer;
    const goalTime = req.body.goal;
    const scored = req.body.scored == 'on' ? 'Y': 'N';

    const {data: penalty, penaltyError} = await supabase
        .from('penalty_shootout')
        .insert({match_no: id, shooter_id: scorerId, score_goal: scored, kick_no_ingame: counter+1, penalty_time: goalTime}).select();


    const {data: penaltyGk, penaltyGkError} = await supabase
        .from('penalty_gk')
        .insert({match_no: id, member_id: goalkeeperId, kick_uuid: penalty[0].kick_uuid})

        // req flash
        req.flash("success", "Successfully Updated Match Penalties");
    res.redirect(`/tournaments/${tournamentId}`);

}