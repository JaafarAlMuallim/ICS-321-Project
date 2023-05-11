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
        member ( * ), registered_team(*, team(*))
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
        .select(`*, member:shooter_id(*, player(*, registered_team(*, team(*)))), penalty_gk:kick_uuid(*, member(*, player(*, registered_team(*, team(*)))))`)
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

module.exports.editGoals = async (req, res, next) => {
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

    res.render('matches/editGoals', {teams, playersData, tournament, match});
}
module.exports.editCards = async (req, res, next) => {
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

    res.render('matches/editCards', {teams, playersData, tournament, match});
}

module.exports.editSubs = async (req, res, next) => {
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

    res.render('matches/editSubs', {teams, playersData, tournament, match});
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
module.exports.editAudience = async (req, res, next) => {
    const {id} = req.params;

    // get the tournament id from url
    const tournamentId = req.originalUrl.split('/')[2];
    // get the tournament data
    const {data: tournament, trError} = await supabase.from('tournament').select().eq('tr_id', tournamentId);
    // get the match from the id
    const {data: match, matchError} = await supabase
    .from('match_played')
    .select('*, venue(*)').eq('match_uuid',id);

    
    res.render('matches/editAudience', {tournament, match});
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
    const penaltyTime = req.body.goal;
    const scored = req.body.scored == 'on' ? 'Y': 'N';

    const {data: penalty, penaltyError} = await supabase
        .from('penalty_shootout')
        .insert({match_no: id, shooter_id: scorerId, score_goal: scored, kick_no_ingame: counter+1, penalty_time: penaltyTime}).select();


    const {data: penaltyGk, penaltyGkError} = await supabase
        .from('penalty_gk')
        .insert({match_no: id, member_id: goalkeeperId, kick_uuid: penalty[0].kick_uuid})

    req.flash("success", "Successfully Updated Match Penalties");
    res.redirect(`/tournaments/${tournamentId}`);
}

module.exports.updateSubs = async (req,res,next) => {
    const {id} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];

    const outPlayer = req.body.out;
    const inPlayer = req.body.in;
    const subTime = req.body.sub;
    const half = subTime > 45 ? 2:1

    // insert two records in player_in_out
    const {data: subs, subsError} = await supabase.from('player_in_out').insert([{match_no:id, member_id: outPlayer, in_out: 'O', play_half: half, play_schedule: 'NT', time_in_out: subTime}, {match_no:id, member_id: inPlayer, in_out: 'I', play_half: half, play_schedule: 'NT', time_in_out: subTime}])

    req.flash("success", "Successfully Updated Match Subsitutions");
    res.redirect(`/tournaments/${tournamentId}`);
}

module.exports.updateCards = async (req, res, next) => {
    const {id} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];

    const bookedPlayer = req.body.booked;
    const bookedTime = req.body.time;
   
    const half = bookedTime > 45 ? 2:1;

    // get previous bookings of the player and in the same match
    const {data: previousBookings, readError} = await supabase.from('player_booked').select().eq('match_no', id).eq('booked_player', bookedPlayer);
    const counter = previousBookings.length ?? 0;
    const redCard = req.body.sent_off == 'on' || counter >=1 ? 'Y':'N';

    // insert in player_booked
    const {data: booking, error} = await supabase.from('player_booked').insert({match_no: id, booked_player: bookedPlayer, booking_time: bookedTime, play_half: half, play_schedule: 'NT', sent_off: redCard});
    req.flash("success", "Successfully Updated Match Bookings and Cards");
    res.redirect(`/tournaments/${tournamentId}`);
}

module.exports.updateGoals = async (req, res, next) => {
    const {id} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];

    const scorer = req.body.scorer;
    const goalTime = req.body.time;
    const half = goalTime > 45 ? 2:1;

    const {data: teams, teamsError} = await supabase.from('match_details').select('team_one, team_two').eq('match_uuid', id);
    const teamUuids = [teams[0].team_one, teams[0].team_two]
    const {data: player, teamError} = await supabase.from('player').select('*, team:team_uuid(*), registered_team:team_uuid(*), member:member_uuid(*)').eq('member_uuid', scorer).in('team_uuid', teamUuids);
    const {data: match, matchError} = await supabase.from('match_played').select('goal_score').eq('match_uuid', id);
    const currentScore = match[0].goal_score;
    var teamOneScore = currentScore.split('-')[0]
    var teamTwoScore = currentScore.split('-')[1]
    if(player[0].team.team_uuid == teamUuids[0]){
        teamOneScore++;
    } else {
        teamTwoScore++;
    }
    const {data: goal, error}  = await supabase.from('goal_details').insert({match_no: id, scorer: scorer, goal_time: goalTime, goal_half: half});
    const {data: matchUpdate, matchUpdateError} = await supabase.from('match_played').update({goal_score: `${teamOneScore}-${teamTwoScore}`}).eq('match_uuid', id);
    req.flash("success", "Successfully Updated Match Goals");
    res.redirect(`/tournaments/${tournamentId}`);
}

module.exports.updateAudience = async (req, res, next) =>{
    const {id} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];
    const audience = req.body.audience;
    const {data: match, error} = await supabase.from('match_played').update({audience: audience}).eq('match_uuid', id);
    req.flash("success", "Successfully Updated Match Audience Number");
    res.redirect(`/tournaments/${tournamentId}`);
} 

module.exports.updateMvp = async (req, res, next) => {
    const {id: playerId} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];
    const matchId = req.originalUrl.split('/')[4];

    const {data: match, error} = await supabase.from('match_played').update({player_of_match: playerId}).eq('match_uuid', matchId);
    req.flash("success", "Successfully Updated Match Player of Match");
    res.redirect(`/tournaments/${tournamentId}`);
}

module.exports.endMatch = async (req, res, next) => {
    const {id} = req.params;
    const tournamentId = req.originalUrl.split('/')[2];

    const {data: penalties, error} = await supabase.from('penalty_shootout').select().eq('match_no', id).eq('score_goal', 'Y');

    const {data: match, matchError} = await supabase.from('match_played').select('goal_score').eq('match_uuid', id);
    const currentScore = match[0].goal_score;
    var teamOne = currentScore.split('-')[0]
    var teamTwo = currentScore.split('-')[1]    
    // update team table by adding 3 points to the winner team in that tournament
    const {data: teams, teamsError} = await supabase.from('match_details').select('team_one, team_two').eq('match_uuid', id);
    const teamUuids = [teams[0].team_one, teams[0].team_two];
    const {data: teamOneData, teamOneError} = await supabase.from('team').select().eq('team_uuid', teamUuids[0]);
    const {data: teamTwoData, teamTwoError} = await supabase.from('team').select().eq('team_uuid', teamUuids[1]);

    if(teamOne > teamTwo){
        // get both teams data
        const {data: winnerUpdate, winnerError} = await supabase.from('team').update({match_played:teamOneData[0].match_played+1, won:teamOneData[0].won + 1, goal_for:teamOneData[0].goal_for + teamOne, goal_against: teamOneData[0].goal_against + teamTwo, goal_diff: teamOneData[0].goal_for + teamOne - teamTwo, points: teamOneData[0].points + 3});
        const {data: loserUpdate, loserError} = await supabase.from('team').update({match_played:teamTwoData[0].match_played+1, lost:teamTwoData[0].lost + 1, goal_for:teamTwoData[0].goal_for + teamTwo, goal_against: teamTwoData[0].goal_against + teamOne, goal_diff: teamTwoData[0].goal_for + teamTwo - teamOne});
    } else if(teamTwo > teamOne) {
        const {data: winnerUpdate, winnerError} = await supabase.from('team').update({match_played:teamTwoData[0].match_played+1, won:teamTwoData[0].won + 1, goal_for:teamTwoData[0].goal_for + teamTwo, goal_against: teamTwoData[0].goal_against + teamOne, goal_diff: teamTwoData[0].goal_for + teamTwo - teamOne, points: teamTwoData[0].points + 3});
        const {data: loserUpdate, loserError} = await supabase.from('team').update({match_played:teamOneData[0].match_played+1, lost:teamOneData[0].lost + 1, goal_for:teamOneData[0].goal_for + teamOne, goal_against: teamOneData[0].goal_against + teamTwo, goal_diff: teamOneData[0].goal_for + teamOne - teamTwo});

    } else {
        const {data: teamOneUpdate, teamOneError} = await supabase.from('team').update({match_played:teamOneData[0].match_played+1, draw:teamOneData[0].draw + 1, goal_for:teamOneData[0].goal_for + teamOne, goal_against: teamOneData[0].goal_against + teamTwo, goal_diff: teamOneData[0].goal_for + teamOne - teamTwo, points: teamOneData[0].points + 1});
        const {data: teamTwoUpdate, teamTwoError} = await supabase.from('team').update({match_played:teamTwoData[0].match_played+1, draw:teamTwoData[0].draw + 1, goal_for:teamTwoData[0].goal_for + teamTwo, goal_against: teamTwoData[0].goal_against + teamOne, goal_diff: teamTwoData[0].goal_for + teamTwo - teamOne, points: teamTwoData[0].points + 1});
    }

    const {data: teamOneGroup, teamOneGroupError} = await supabase.from('team').select().eq('group', teamOneData[0].group).order('points', {ascending: false});
    // update all records of teamOneGroup and give them a {position:} as their index in the array
    for(let i = 0; i < teamOneGroup.length; i++){
        const {data: teamOneGroupUpdate, teamOneGroupUpdateError} = await supabase.from('team').update({position: i+1}).eq('team_uuid', teamOneGroup[i].team_uuid);
    }
    const {data: ended, error3} = await supabase.from('match_details').update({status: 'finished',goal_score: teamOne+teamTwo, win_lose: teamOne == teamTwo ? 'D':'W', penalty_score: penalties.length?? 0}).eq('match_uuid', id);
    req.flash("success", "Successfully Ended Match");
    res.redirect(`/tournaments/${tournamentId}`);
}

