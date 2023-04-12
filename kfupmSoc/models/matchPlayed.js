class MatchPlayed {
    constructor(match_no, play_stage, play_date, results, decided_by, goal_score, venue_id, referee_id, audience, player_of_match, stop1_sec, sotp2_sec){
        this.match_no = match_no;
        this.play_stage = play_stage;
        this.play_date = play_date;
        this.results = results;
        this.decided_by = decided_by;
        this.goal_score = goal_score;
        this.venue_id = venue_id;
        this.referee_id = referee_id;
        this.audience = audience;
        this.player_of_match = player_of_match;
        this.stop1_sec = stop1_sec;
        this.stop2_sec = stop2_sec;
    }
}