if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');


module.exports.clients = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);
supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);



module.exports.index = async (req, res) => {
    const find = await supabase.from('tournament').select().order('start_date', { ascending: true });
    const tournaments = find.data;
    return res.render("tournaments/index", { tournaments })
}

module.exports.new = (req, res) => {
    return res.render("tournaments/new")
}

module.exports.createTournament = async (req, res, next) => {
    const data = req.body.tournament;
    const admin = req.session.user.admin_id;
    const { data: tournament, error } = await supabase
        .from('tournament')
        .insert([
            { tr_name: data.name, start_date: data.start_date, end_date: data.end_date, admin_id: admin },
        ]).select();
    if (error) {
        req.flash("error", error.message);
        res.redirect("/tournaments/new");
        return;
    }
    req.flash("success", "Successfully Created The Tournament, Wait for team to Join!")
    res.redirect(`/tournaments/${tournament[0].tr_id}`);
}
module.exports.showTournament = async (req, res, next) => {
    
    const { id } = req.params;
    const { data: tournaments, errorCounter, status } = await supabase
    .from("tournament")
    .select().eq('tr_id', id);

    const tournament = tournaments[0];
    const { data: teamsData } =
        await supabase.from('team').select('*, registered_team (*)').eq('tr_id', id);
    const teamUuids = [];
    for (let team of teamsData) {
        teamUuids.push(team.team_uuid);
    }
    const { data: matchesData } = await supabase
        .from('match_details')
        .select(
            '*, match_played:match_uuid (*, referee (*), member:player_of_match(*)), asst_referee (*)')
        .eq('tr_id', id).order('match_id', id);
    const matchUuids = [];
    for (let match of matchesData) {
        matchUuids.push(match.match_uuid);
    }
    const { data: venueData } =
        await supabase.from('venue').select('*, match_played (venue_id)');

        const matches = [];
        for (let doc of matchesData) {
            const teams = [];
            for (let doc1 of teamsData) {
              if (doc1.team_uuid == doc.team_one ||
                  doc1.team_uuid == doc.team_two) {
                teams.push(doc1);
              }
            }
            matches.push(teams);
          }

          const venues = [];
          for (let doc of matchesData) {
            for (let doc1 of venueData) {x
              if (doc1.venue_id == doc.match_played.venue_id) {
                venues.push(doc1);
              }
            }
          }

    if (!teamsData) {
        req.flash("error", "Cannot Find Tournament!");
        return res.redirect("/tournaments");
    }
    res.render("tournaments/show", { teamsData, matchesData, venues, tournament, matches});
}

module.exports.deleteTournament = async (req, res, next) => {
    const { id } = req.params;
    const { data: data, error } = await supabase
        .from('tournament')
        .delete().eq('tr_id', id);

    if (error) {
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
    res.render('tournaments/edit', { tournament });
}
module.exports.updateTournament = async (req, res, next) => {
    const data = req.body.tournament;
    const { id } = req.params;
    const { data: counter, errorCounter, status } = await supabase
        .from("tournament")
        .select()
    const { data: tournament, error } = await supabase
        .from('tournament')
        .update([
            { tr_name: data.name, start_date: data.start_date, end_date: data.end_date },
        ]).eq('tr_id', id)
    if (error) {
        req.flash("error", error.message);
        res.redirect(`/tournaments/${id}`);
    } else {
        req.flash("success", "Successfully Updated The Tournament")
        res.redirect(`/tournaments/${id}`);

    }
}
module.exports.showGroups = async (req, res, next) => {
    const { id } = req.params;
    // fetch all teams from supabase and pass it to the view
    const { data: teams, errorCounter, status } = await supabase
        .from("team")
        .select('*, registered_team(*)')
    res.render('tournaments/groups', { id, teams })
}
module.exports.createGroups = async (req, res, next) => {
    const { id } = req.params;
    // const { data: teams, errorCounter, status } = await supabase
    //     .from("team")
    //     .select()
    // res.render('tournaments/groups', {id,teams})
    res.redirect('/tournaments/id')
}
module.exports.showTeams = async (req, res, next) => {
    const { id } = req.params;

    // get tournament from id
    const { data: tournament, error } = await supabase
        .from('tournament')
        .select()
        .eq('tr_id', id);
    const { data: teams, errorCounter, status } = await supabase
        .from("team")
        .select('*, registered_team(*)');
    res.render('tournaments/teams', { tournament, id, teams })
}