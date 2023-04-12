class Team {
    constructor(team_uuid, team_id, tr_id, team_group, match_played, won, draw, lost, goal_for, goal_against, goal_diff, points, group_position){
        this.team_uuid = team_uuid;
        this.team_id = team_id;
        this.tr_id = tr_id;
        this.team_group = team_group;
        this.match_played = match_played;
        this.won = won;
        this.draw = draw;
        this.lost = lost;
        this.goal_for = goal_for;
        this.goal_against = goal_against;
        this.goal_diff = goal_diff;
        this.points = points;
        this.group_position = group_position;
    }
}