
if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const client = require('@supabase/supabase-js');
const supabase = client.createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

module.exports.index = async (req, res) => {
    // const tournaments = await Tournament.find();
    const {id} = req.params;

    // select the team only 
    const {data: team, errorTeam} = await supabase
        .from('team')
        .select()
        .eq('team_uuid', id);

    const { data: teamPlayers, errorTeams } = await supabase
        .from('team')
        .select(`*,
        player ( *, team ( team_uuid, team_id, tr_id, team_group ))
        `).eq('team_uuid', id)
        .order('team_uuid', { ascending: true });

    const {data: captains, errorCaptain} = await supabase
        .from('team')
        .select(`*,
            player(*, team( team_uuid, team_id, tr_id, team_group ), match_captain(*))`)
        .eq('team_uuid', id);
    // add all records match_captain to an array
    const captainsArray = [];
    console.log(captains[0].player.length)
    for(let k = 0; k < captains[0].player.length; k++){
            if(captains[0].player[k].match_captain.length != 0){
                for(let i = 0; i < captains[0].player[k].match_captain.length ; i++){
                    captainsArray.push(captains[0].player[k]);
                }
            }
    }
    
    console.log(captainsArray[0]);
    
    const { data: coaches, errorCoaches } = await supabase.from('team_coaches')
    .select(`*,
    coach ( coach_id, coach_name )
    `).eq('team_tr', id)

    const players = teamPlayers[0].player
    res.render('teams/index', {team, teamPlayers, players, captainsArray, coaches})
    }

module.exports.changeCaptain = async (req, res) => {
    const {id} = req.params;
    const {newCaptain} = req.body;
    const {data: team, errorTeam} = await supabase
        .from('team')
        .select()
        .eq('team_uuid', id);
    
    // get count of the number of matches
    const {data: matches, errorMatches} = await supabase
        .from('match')
        .select()
        .eq('match_group', team[0].team_group);
        
    // upsert new captain 
    const {data: newCaptainData, errorNewCaptain} = await supabase
        .from('match_captain')
        .upsert({
            team_tr: id,
            player_id: newCaptain,
            match_id: team[0].team_group
        });
}