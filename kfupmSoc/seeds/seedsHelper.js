
const client = require('@supabase/supabase-js');
const {adminId, adminFirst, adminLast, phoneNum} = require('./admins.js');
const {fname, lname, ids, emails, bdates, deptCode} = require('./members.js');
const {code, deptName, first, last} = require('./depts.js');
const {nums, teamName, teamEmail, teamWeb, teamAddress, managerIds, coachesId, tournamentNum} = require('./teams.js');
const {tournamentsNums, tournamentsNames, tournamentStartDate, tournamentEndDate, adminId: ad} = require('./tournaments.js');
const {fieldId, fieldName, fieldStatus, fieldSize, fieldCapacity, description} = require('./fields.js');
const {matchId, matchStartTime, matchFinishTime, matchRefereeName, firstTeam, secondTeam, fieldId:fid} = require('./matches.js');
const {tournamentNums:tn, teamNums, teamTelephones} = require('./contanctNum.js');
const {matchId:mId, playerId, redCard} = require('./cards.js');
const {matchId:m_Id, scorerId, times} = require('./goal.js');
const {type:ftype, ids:fids} = require('./faculty.js');
const {type:stype, ids:sids} = require('./staff.js');
const {ids:kId, phoneNums} = require('./telephones');
const {playerJoin, playerLeft, MatchNum, time} = require('./subsititues.js');
const {matchId:med, penaltyScored, penaltyTime, penaltyType, penaltyShoorterId, penaltyGoalKeeper} = require('./penalties.js');
const {teamOne, teamTwo, teamNum, tournamentNum:tn2, type} = require('./joins.js');
require('dotenv').config();
const supabaseUrl = process.env.SUPABASE_URL;

const supabaseKey = process.env.SUPABASE_KEY;
var supabase;
function connect(){
    supabase =  client.createClient(supabaseUrl, supabaseKey);
   
}

connect();

async function writeAdmins(){
    for(var i = 0; i < adminId.length; i++){
        const { data, error } = await supabase
        .from('Admin')
        .insert([
            {admin_id: adminId[i], fname: adminFirst[i], lname: adminLast[i], phone_num: phoneNum[i]}
        ])
        console.log(data, error);
    }
}

async function writeDepts(){
    for(var i = 0; i < code.length; i++){
        const { data, error } = await supabase
        .from('Department')
        .insert([
            {code: code[i], dept_name: deptName[i], chair_fname: first[i], chair_lname: last[i]}
        ])
        console.log(data, error);
    }

}
async function writeTournaments(){
    for(var i = 0; i < tournamentsNums.length; i++){
        const { data, error } = await supabase
        .from('Tournament')
        .insert([
            {tournament_num: tournamentsNums[i], name: tournamentsNames[i],  start: tournamentStartDate[i], end: tournamentEndDate[i], admin_id: ad[i]}
        ])
        console.log(data, error);
    }
}

async function writeMember(){
    for(var i = 0; i < 36; i++){
        const { data, error } = await supabase
        .from('Member')
        .insert([
            {kfupm_id: ids[i], fname: fname[Math.floor(Math.random()* fname.length)], lname: lname[Math.floor(Math.random()* lname.length)], email: emails[Math.floor(Math.random()* emails.length)], b_date: bdates[Math.floor(Math.random()* bdates.length)], dept_code: deptCode[Math.floor(Math.random()* deptCode.length)]}
        ])
        console.log(data, error);
    }
}


async function writeTeams(){
    for(var i = 0; i < nums.length; i++){
        const { data, error } = await supabase
        .from('Team')
        .insert([
            {team_num: nums[i], name: teamName[i], tournament_num: tournamentNum[i], manager_id: managerIds[i], coach_id: coachesId[i], email: teamEmail[i], website: teamWeb[i], address: teamAddress[i],}
        ])
        console.log(data, error);
    }
}

async function writeFields(){
    for(var i = 0; i < fieldId.length; i++){
        var index = Math.floor(Math.random()*fieldSize.length);
        const { data, error } = await supabase
        .from('Field')
        .insert([
            {field_id: fieldId[i], field_name: fieldName[i], status: fieldStatus[Math.floor(Math.random() * fieldStatus.length)], size: fieldSize[index], capacity: fieldCapacity[index], description: description[i]}
        ])
        console.log(data, error);
    }
}
async function writeMatches(){
    for(var i = 0; i < matchId.length; i++){
        const { data, error } = await supabase
        .from('Match')
        .insert([
            {match_id: matchId[i], start_date_time: matchStartTime[i], end_date_time: matchFinishTime[i], referee_fname: matchRefereeName[i], referee_lname: matchRefereeName[i], first_team_id: firstTeam[i], second_team_id: secondTeam[i], field_id: fieldId[i]}
        ])
        console.log(data, error);
    }
}

async function writeContactNums(){
    for(var i = 0; i < teamNums.length*2; i++){
        const { data, error } = await supabase
        .from('Contact_Nums')
        .insert([
            {phone_num: teamTelephones[i], team_num: teamNums[i%4], tournament_num: tn[0]}
        ])
        console.log(data, error);
    }
}
async function writeCards(){
    for(var i = 0; i < playerId.length; i++){
        const { data, error } = await supabase
        .from('Card')
        .insert([
            {match_id: mId[i%2], kfupm_id: playerId[i], red_card: redCard[i]}
        ])
        console.log(data, error);
    }
}

async function writeGoals(){
    // depending on time insert goals in database.
    for(var i = 0; i < times.length; i++){
        const { data, error } = await supabase
        .from('Goal')
        .insert([
            {match_id: m_Id[i%2], scorer_id: scorerId[i%4], time: times[i]}
        ])
        console.log(data, error);
}
}
async function writeFaculty(){
    for(var i = 0; i < fids.length; i++){
        const { data, error } = await supabase
        .from('Faculty')
        .insert([
            {kfupm_id: fids[i], type: ftype[Math.floor(Math.random()*ftype.length)]}
        ])
        console.log(data, error);
    }

}

async function writeStudents(){
    for(var i = 0; i < stids.length; i++){
        const { data, error } = await supabase
        .from('Student')
        .insert([
            {kfupm_id: stids[i], year: year[Math.floor(Math.random()*year.length)]}
        ])
        console.log(data, error);
    }
}

async function writeStaff(){
    for(var i = 0; i < sids.length; i++){
        const { data, error } = await supabase
        .from('Staff')
        .insert([
            {kfupm_id: sids[i], type: stype[Math.floor(Math.random()*stype.length)]}
        ])
        console.log(data, error);
    }
}
async function writeTelephones(){
    for(var i = 0; i < phoneNums.length; i++){
        const { data, error } = await supabase
        .from('Telephone')
        .insert([
            {phone_num: phoneNums[i], kfupm_id: kId[i%kId.length]}
        ])
        console.log(data, error);
    }
}

async function writeSubs(){
    for(var i = 0; i < time.length; i++){
        const { data, error } = await supabase
        .from('Subsitiutes')
        .insert([
            {match_id: MatchNum[i%2], joined_id: playerJoin[i], left_id: playerLeft[i], time: time[i]}
        ])
        console.log(data, error);
    }
}

async function writePenalties(){
    for(var i = 0; i < penaltyTime.length; i++){
        const { data, error } = await supabase
        .from('Penalty')
        .insert([
            {match_id: med[i%2], type: penaltyType[Math.floor(Math.random()*penaltyType.length)], time: penaltyTime[i], scored: penaltyScored[i], goal_keeper: penaltyGoalKeeper[i], shooter: penaltyShoorterId[i]}
        ])
        console.log(data, error);
    }
}

async function writeJoins(){
    for(var i = 0; i < teamOne.length; i++){
        const { data, error } = await supabase
        .from('Joins')
        .insert([
            {team_num: teamNum[0], tournament_num: tn2[0], kfupm_id: teamOne[i], type: type[0]}
        ])
        console.log(data, error);
    }
    for(var i = 0; i < teamTwo.length; i++){
        const { data, error } = await supabase
        .from('Joins')
        .insert([
            {team_num: teamNum[1], tournament_num: tn2[0], kfupm_id: teamTwo[i], type: type[0]}
        ])
        console.log(data, error);
    }
}
// writeAdmins();
// writeDepts();
// writeTournaments();
// writeTeams();
// writeMember();
// writeFields();
// writeMatches();
// writeContactNums();
// writeCards();
// writeGoals();
// writeStudents();
// writeFaculty();
// writeStaff();
// writeTelephones();
// writeSubs();
// writePenalties();
// writeJoins();