
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
    const teamUuids = [];
    for (let team of teamsData) {
      teamUuids.push(team['team_uuid']);
    }

    const {data: manager} = await supabase.from('registered_team').select('*, member:created_by(*)').eq('team_uuid', id);
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
        .eq('approved', 'true')
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
    res.render('teams/index', {team, captains, coaches, playersData, manager})
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

module.exports.approveTeam = async (req, res, next) => {
    const trId = req.originalUrl.split('/')[req.originalUrl.split('/').length - 1];
    const id = req.originalUrl.split('/')[2];
    const { data: team, error } = await supabase
    .from('team')
    .update({'approved' : 'true'})
    .eq('team_uuid', id).eq('tr_id', trId);

    // get name of the tournament
    const {data: tournament, error1} = await supabase
    .from('tournament')
    .select('*')
    .eq('tr_id', trId);
    req.flash(`success', 'Team Successfully Approved in Joining ${tournament[0].tr_name}`);
    res.redirect('/requests');
}
// decline method
module.exports.declineTeam = async (req, res, next) => {
    const trId = req.originalUrl.split('/')[req.originalUrl.split('/').length - 1];
    const id = req.originalUrl.split('/')[2];
    const { data: team, error } = await supabase
    .from('team')
    .update({'approved' : 'false'})
    .eq('team_uuid', id).eq('tr_id', trId);

    // get name of the tournament
    const {data: tournament, error1} = await supabase
    .from('tournament')
    .select('tr_name')
    .eq('tr_id', trId);


    req.flash(`success', 'Team Declined From Joining ${tournament[0].tr_name}`);
    res.redirect('/requests');
}

module.exports.changeManager = async (req, res) => {
    const {id} = req.params;
    const teamId = req.originalUrl.split('/')[2];
    const {data:exists, error1} = await supabase.from('registered_team').select().eq('team_uuid', teamId);
    if(exists.length > 0){
        const {data, error} = await supabase
        .from('registered_team')   
        .update({created_by: id})
        .eq('team_uuid', teamId)
        .select()
    }else{
        const {data, error} = await supabase
        .from('registered_team')
        .upsert({team_uuid: teamId, created_by: id})
        .select()
    }
    res.redirect(`/teams/${teamId}`)   
}

module.exports.changeCoach = async (req, res) => {
    const {id} = req.params;
    const teamId = req.originalUrl.split('/')[2];
    const {data:exists, error1} = await supabase.from('team_coach').select().eq('team_uuid', teamId);
    
    if(exists.length > 0){
        const {data, error} = await supabase
        .from('team_coach')   
        .update({member_uuid: id})
        .eq('team_uuid', teamId)
        .select()
    }else{
        const {data, error} = await supabase
        .from('team_coach')
        .upsert({team_uuid: teamId, member_uuid: id})
        .select()
    }
    res.redirect(`/teams/${teamId}`)   
}

// approveCaoch
module.exports.approveCoach = async (req, res, next) => {
    const memberId = req.originalUrl.split('/')[req.originalUrl.split('/').length - 1];
    const id = req.originalUrl.split('/')[2];
    const {data:exists, error1} = await supabase.from('team_coach').select().eq('team_uuid', id);
    
    if(exists.length > 0){
        await supabase
        .from('team_coach')   
        .delete()
        .eq('team_uuid', id).eq('approved', 'pending').eq('member_uuid', memberId)
        .select()
        await supabase
        .from('team_coach')   
        .update({member_uuid: memberId})
        .eq('team_uuid', id).eq('approved', 'true');
    }

    const { data: coach, error } = await supabase
    .from('team_coach')
    .select('*, member(*), registered_team(*)')
    .eq('memeber_uuid', memberId).eq('team_uuid', id);


    req.flash(`success', '${coach[0].member.name} Successfully Approved in Joining ${coach[0].registered_team.name}`);
    res.redirect('/requests');
}

// declineCoach
module.exports.declineCoach = async (req, res, next) => {
    const memberId = req.originalUrl.split('/')[req.originalUrl.split('/').length - 1];
    const id = req.originalUrl.split('/')[2];
    const { data: coach, error } = await supabase
    .from('team_coach')
    .update({'approved' : 'false'})
    .eq('member_uuid', memberId).eq('team_uuid', id).select('*, member(*), registered_team(*)');

    req.flash(`success', '${coach[0].member.name} Declined in Joining ${coach[0].registered_team.name}`);
    res.redirect('/requests');
}