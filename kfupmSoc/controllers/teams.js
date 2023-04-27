
if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');
const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

module.exports.allTeams = async (req, res) => {

    const {data: teams, error} = await supabase.from('team').select('*, registered_team(*)').order('team_id', {ascending: true});
    res.render('teams/allTeams', {teams})
}

module.exports.index = async (req, res) => {

    const {id} = req.params;

    const {data: teamsData} = await supabase
        .from('team')
        .select('*, registered_team(*)')
        .eq('team_uuid', id)
        .order('team_id', {ascending: true});

    const team = teamsData[0];
    console.log(team);
    const teamUuids = [];
    for (let team of teamsData) {
      teamUuids.push(team['team_uuid']);
    }
    // get team captains
    const {data: captainsData} = await supabase
        .from('team_captain')
        .select('*, member(*, player(*))')
        .in('team_uuid', teamUuids);
        
    const {data: coachesData} = await supabase
        .from('team_coach')
        .select('*, member (*)')
        .in('team_uuid', teamUuids);

    // get players in team
    const {data:playersData} = await supabase
        .from('player')
        .select('*, member(*)')
        .in('team_uuid', teamUuids)
        .eq('approved', 'approved')
        .order('jersey_no', {ascending: true});

        const captains = [];
        const coaches = [];
        for(let captain of captainsData){
            if(team.team_uuid == captain.team_uuid){
                captains.push(captain);
            }
        }
            for (let coach of coachesData) {
              if (team.team_uuid == coach.team_uuid) {
                coaches.push(coach);
              }
            }
    res.render('teams/index', {team, captains, coaches, playersData})
    }

module.exports.changeCaptain = async (req, res) => {
    const {id} = req.params;
    const teamId = req.originalUrl.split('/')[2];
    const {data:exists, error1} = await supabase.from('team_captain').select().eq('team_uuid', teamId);
    
    // if exists then we update the column if not we insert new one
    if(exists.length > 0){
        const {data, error} = await supabase

        .from('team_captain')   
        .update({member_uuid: id})
        .eq('team_uuid', teamId)
        .select()
    }else{
        const {data, error} = await supabase
        .from('team_captain')
        .upsert({team_uuid: teamId, member_uuid: id})
        .select()
    }
    res.redirect(`/teams/${teamId}`)
    
}