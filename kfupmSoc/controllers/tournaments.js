if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');


module.exports.clients = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);
supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);



module.exports.index = async (req, res) => {
    const {data: tournaments} = await supabase.from('tournament').select().order('start_date', { ascending: true });
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
            '*, match_played:match_uuid (*, referee (*), member:player_of_match(*)), asst_referee (*)').eq('tr_id', id)
        .order('play_date', {ascending:true});
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
            for (let doc1 of venueData) {
              if (doc1.venue_id == doc.match_played.venue_id) {
                venues.push(doc1);
              }
            }
          }
    const { data: playersData, err } = await supabase
        .from('player')
        .select('*, member:member_uuid(*), team:team_uuid(*)')
        .in('team_uuid', teamUuids);
    if (!teamsData) {
        req.flash("error", "Cannot Find Tournament!");
        return res.redirect("/tournaments");
    }
    res.render("tournaments/show", { playersData, teamsData, matchesData, venues, tournament, matches});
}

module.exports.deleteTournament = async (req, res, next) => {
    const { id } = req.params;
    const { data: data, error } = await supabase
        .from('tournament')
        .delete();

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
        .select('*').eq('tr_id', id);
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
        ]);
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
    // fetch all teams from supabase and pass  it to the view
    const { data: teams, errorCounter, status } = await supabase
        .from("team")
        .select('*, registered_team(*)').eq('tr_id', id);
    res.render('tournaments/groups', { id, teams })
}
module.exports.createGroups = async (req, res, next) => {
    const { id } = req.params;
    const data = req.body;

    const {data: aGroup} = await supabase.from('registered_team').select().in('team_name', data.arrayA);
    const {data: bGroup} = await supabase.from('registered_team').select().in('team_name', data.arrayB);
    const {data: cGroup} = await supabase.from('registered_team').select().in('team_name', data.arrayC);
    const {data: dGroup} = await supabase.from('registered_team').select().in('team_name', data.arrayD);

    // update the group from team table
    const { data: teams, errorCounter, status } = await supabase
        .from("team")
        .update([
            { team_group: 'A' },
        ]).in('team_uuid', aGroup.map(team => team.team_uuid)).eq('tr_id', id);
    const { data: teams1, errorCounter1, status1 } = await supabase
        .from("team")
        .update([
            { team_group: 'B' },
        ]).in('team_uuid', bGroup.map(team => team.team_uuid)).eq('tr_id', id);
    const { data: teams2, errorCounter2, status2 } = await supabase
        .from("team")
        .update([
            { team_group: 'C' },
        ]).in('team_uuid', cGroup.map(team => team.team_uuid)).eq('tr_id', id);
    const { data: teams3, errorCounter3, status3 } = await supabase
        .from("team")
        .update([
            { team_group: 'D' },
        ]).in('team_uuid', dGroup.map(team => team.team_uuid)).eq('tr_id', id);

        if(errorCounter || errorCounter1 || errorCounter2 || errorCounter3){
            req.flash("error", errorCounter.message);
            res.redirect(`/tournaments/${id}/groups`);
            return;
        }
        req.flash("success", "Successfully Created Tournament Groups")
        res.redirect('/tournaments')
}
module.exports.showTeams = async (req, res, next) => {
    const { id } = req.params;

    // get tournament from id
    const { data: tournament, error } = await supabase
        .from('tournament')
        .select().eq('tr_id', id);
    const { data: teams, errorCounter, status } = await supabase
        .from("team")
        .select('*, registered_team(*)').eq('tr_id', id).order('points', {ascending : true});

    // create array for each team_group
    const groupA = [];
    const groupB = [];
    const groupC = [];
    const groupD = [];
    teams.forEach(team => {
        if (team.team_group === 'A') {
            groupA.push(team);
        } else if (team.team_group === 'B') {
            groupB.push(team);
        } else if (team.team_group === 'C') {
            groupC.push(team);
        } else if (team.team_group === 'D') {
            groupD.push(team);
        }
    });
    res.render('tournaments/teams', { tournament, id, teams, groupA, groupB, groupC, groupD })
}
module.exports.initiate = async(req, res, next) => {
    const {id} = req.params;

    // get tournament
    const { data: tour, tourError } = await supabase
        .from('tournament')
        .select().eq('tr_id', id);  

        const startDate = new Date(tour[0].start_date);
        const endDate = new Date(tour[0].end_date);
        const startMillis = startDate.getTime();
        const endMillis = endDate.getTime();


        const {data: aGroup} = await supabase.from('team').select().eq('team_group', 'A').eq('tr_id', id);
        const {data: bGroup} = await supabase.from('team').select().eq('team_group', 'B').eq('tr_id', id);
        const {data: cGroup} = await supabase.from('team').select().eq('team_group', 'C').eq('tr_id', id);
        const {data: dGroup} = await supabase.from('team').select().eq('team_group', 'D').eq('tr_id', id);

        for (let i = 0; i < aGroup.length; i++) {
            for (let j = 0; j < aGroup.length; j++) { 
            const randomMillis = startMillis + Math.floor(Math.random() * (endMillis - startMillis));
            const randomDate = new Date(randomMillis);
                if(i != j){
                    const {data: referee, errorReferee} = await supabase.rpc('get_random_referee')
                    const {data: venue, errorVenue} = await supabase.rpc('get_random_venue')
                    const {data: asst_ref, errorAsstRef} = await supabase.rpc('get_random_asst_ref')
                    const {data: records } = await supabase.from('match_played').select('match_uuid');
                    const count = records.length;
                    const {data: matchPlayed, error} = await supabase.from('match_played').insert([{play_stage: 'G', venue_id: venue[0].venue_id, referee_id: referee[0].referee_uuid, match_id: count + 1}]).select();
                    await supabase.from('match_details').insert([{match_uuid: matchPlayed[0].match_uuid, play_stage: 'G', asst_ref: asst_ref[0].asst_ref_id, tr_id: id, team_one:aGroup[i].team_uuid, team_two: aGroup[j].team_uuid, match_id: matchPlayed[0].match_id, play_date:randomDate}]);
                }
            }
        }
        for (let i = 0; i < bGroup.length; i++) {
            for (let j = 0; j < bGroup.length; j++) {
                if(i != j){
                    const {data: matchPlayed, error} = await supabase.from('match_played').insert([{team1: bGroup[i].team_uuid, team2: bGroup[j].team_uuid, tr_id: id}]);
                }
            }
        }
        for (let i = 0; i < cGroup.length; i++) {
            for (let j = 0; j < cGroup.length; j++) {
                if(i != j){
                    const {data: matchPlayed, error} = await supabase.from('match_played').insert([{team1: cGroup[i].team_uuid, team2: cGroup[j].team_uuid, tr_id: id}]);
                }
            }
        }
        for (let i = 0; i < dGroup.length; i++) {
            for (let j = 0; j < dGroup.length; j++) {
                if(i != j){
                    const {data: matchPlayed, error} = await supabase.from('match_played').insert([{team1: dGroup[i].team_uuid, team2: dGroup[j].team_uuid, tr_id: id}]);
                }
            }
        }
        const { data: tournament, error } = await supabase
        .from('tournament')
        .update([{initiated: true}]).eq('tr_id', id);

        req.flash("success", "Successfully Initiated Tournament and Shuffled Matches")
    res.redirect(`/tournaments/${id}`);
}