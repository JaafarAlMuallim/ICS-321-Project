if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');


module.exports.clients = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);
supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);



module.exports.index = async (req, res) => {
    const find = await supabase.from('tournament').select().order('tr_id', { ascending: true });
    const tournaments = find.data;
    return res.render("tournaments/index", { tournaments })
}

module.exports.new = (req, res) => {
   return res.render("tournaments/new")
}

module.exports.createTournament = async (req, res, next) => {
    const data = req.body.tournament;
    const admin = req.session.user.admin_id;
    const { data: counter, errorCounter, status } = await supabase
	.from("tournament")
	.select() 
    const { data: tournament, error } = await supabase
        .from('tournament')
        .insert([
            { tr_id: counter.length + 1 ,tr_name: data.name, start_date: data.start_date, end_date: data.end_date, adminstrator: admin },
        ]);
    if(error){
        req.flash("error", error.message);
        res.redirect("/tournaments/new");
        return;
    }
    req.flash("success", "Successfully Created The Tournament")
    res.redirect(`/tournaments/${tournament.tr_id}`);
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

    const captains = await supabase.from('match_captain').select().in('match_no', matchArr);
    const captainsData = captains.data;

    const matchesPlayed = await supabase.from('match_played').select().in('match_no', matchArr);
    const played = matchesPlayed.data
    const playersOfMatch = []
    for(let i = 0; i < matchesPlayed.data.length; i++){
        for(let j = 0; j < players.data.length; j++){
            if(matchesPlayed.data[i].player_of_match == players.data[j].player_uuid){
                playersOfMatch.push(players.data[j])
            }
        }
    }
    const tournamentID = req.params.id;
    const tournamentData = await supabase.from('tournament').select().eq('tr_id', tournamentID).limit(1);
    const tournament = tournamentData.data[0];
    if(!tournamentData){
        req.flash("error", "Cannot Find Tournament!");
        return res.redirect("/tournaments");
    } 
    res.render("tournaments/show", {played, playersOfMatch ,playersData, captainsData, refereeData, venueData, tournament});
}

module.exports.deleteTournament = async (req, res, next) => {
    const {id} = req.params;
    const { data: data, error } = await supabase
    .from('tournament')
    .delete().eq('tr_id',id);
    
    if(error){
        req.flash("error", error.message);
        res.redirect("/tournaments");
    } else {
        req.flash("success", "Successfully Deleted The Tournament")
        res.redirect("/tournaments");
    }
}
module.exports.editTournament = async (req, res, next) => {
    const { id } = req.params;

    const { data: tournaments, error } = await supabase
        .from('tournament')
        .select('*')
        .eq('tr_id', id);
    if (error) {
        req.flash("error", error.message);
        res.redirect("/tournaments");
        return;
    }
    const tournament = tournaments[0]
    res.render('tournaments/edit', {tournament});
}
module.exports.updateTournament = async (req, res, next) => {
    const data = req.body.tournament;
    const {id} = req.params;
    const { data: counter, errorCounter, status } = await supabase
	.from("tournament")
	.select() 
    const { data: tournament, error } = await supabase
        .from('tournament')
        .update([
            { tr_name: data.name, start_date: data.start_date, end_date: data.end_date },
        ]).eq('tr_id', id)
    if(error){
        req.flash("error", error.message);
        res.redirect(`/tournaments/${id}`);
    } else {
        req.flash("success", "Successfully Updated The Tournament")
        res.redirect(`/tournaments/${id}`);

    }
}