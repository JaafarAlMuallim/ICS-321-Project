CREATE TABLE admin (
admin_id numeric NOT NULL,
admin_fname varchar(40) NOT NULL,
admin_lname varchar(40) NOT NULL,
phone_num char(10) NOT NULL,
primary KEY (admin_id)
);

INSERT INTO admin VALUES (1, 'Ali', 'Mohammad', '0530000000');
INSERT INTO admin VALUES (2, 'Mohammad', 'Ali', '0530000001');
INSERT INTO admin VALUES (3, 'Ahmad', 'Mohammad', '0530000002');


CREATE TABLE tournament (
tr_id numeric NOT NULL,
tr_name varchar(40) NOT NULL, 
start_date date NOT NULL,
end_date date NOT NULL,
adminstrator numeric NOT NULL,
foreign key(adminstrator) references admin (admin_id),
PRIMARY KEY (tr_id));


INSERT INTO tournament VALUES (1, 'Faculty Tournament', '2023-03-10', '2023-03-25', 1); 
INSERT INTO tournament VALUES (2, 'Open Tournament', '2023-03-15', '2023-03-30', 2);
INSERT INTO tournament VALUES (3, 'Student Tournament', '2022-12-10', '2022-12-02', 3); 
INSERT INTO tournament VALUES (4, 'Staff Tournament', '2023-02-15', '2023-02-25', 3); 
INSERT INTO tournament VALUES (5, 'Annual Tournament', '2023-01-01', '2023-01-15', 1);


CREATE TABLE venue (
venue_id numeric NOT NULL,
venue_name varchar(30) NOT NULL, 
venue_status char(1) NOT NULL, 
aud_capacity numeric NOT NULL,
PRIMARY KEY (venue_id) );

INSERT INTO venue VALUES (11, 'Main Stadium', 'Y', 20000);
INSERT INTO venue VALUES (22, 'Indoor Stadium', 'Y', 1000); 
INSERT INTO venue VALUES (33, 'Jabal Field', 'N', 500); 
INSERT INTO venue VALUES (44, 'Student Field', 'Y', 2000);

CREATE TABLE team (
team_uuid serial NOT NULL,
team_id numeric NOT NULL,
tr_id numeric NOT NULL, 
team_group char(1) NOT NULL,
match_played numeric NOT NULL, 
won numeric NOT NULL,
draw numeric NOT NULL,
lost numeric NOT NULL,
goal_for numeric NOT NULL, 
goal_against numeric NOT NULL, 
goal_diff numeric NOT NULL,
points numeric NOT NULL, 
group_position numeric NOT NULL,
FOREIGN KEY (tr_id) REFERENCES tournament (tr_id),
PRIMARY KEY (team_uuid));
 
INSERT INTO team VALUES (1, 1214,1,'A', 3, 0, 3, 0, 4, 4, 0, 3, 1); 
INSERT INTO team VALUES (2, 1215,1,'B', 3, 1, 1, 1, 3, 4, -1 ,4 ,2); 
INSERT INTO team VALUES (3, 1216,2,'C', 3, 1, 1, 1, 0, 0, 0, 4, 2); 
INSERT INTO team VALUES (4, 1217,2,'A', 3, 1, 1, 1, 1, 4, -3 ,4 ,1); 
INSERT INTO team VALUES (5, 1216,3,'A', 3, 1, 1, 1, 2, 4, -2 ,4 ,3);  
INSERT INTO  team VALUES (6, 1217,3,'B', 3, 1, 1, 1, 4, 2, 2, 4, 1); 
INSERT INTO team VALUES (7, 1218,3,'C', 3, 1, 1, 1, 1, 2, -1 ,4 ,2);

CREATE TABLE playing_position ( 
position_id char(2) NOT NULL,
position_desc varchar(15) NOT NULL,
PRIMARY KEY (position_id) );


INSERT INTO playing_position VALUES ('GK', 'Goalkeepers'); 
INSERT INTO playing_position VALUES ('DF', 'Defenders'); 
INSERT INTO playing_position VALUES ('MF', 'Midfielders'); 
INSERT INTO playing_position VALUES ('FD', 'Forwards');


CREATE TABLE player (
player_uuid serial NOT NULL,
player_id numeric NOT NULL,
team_tr serial NOT NULL,
jersey_no numeric NOT NULL,
player_name varchar(40) NOT NULL,
position_to_play char(2) NOT NULL,
dt_of_bir date,
phone_num char(10) NOT NULL,
FOREIGN KEY (team_tr) REFERENCES team (team_uuid),
PRIMARY KEY (player_uuid)
);

INSERT INTO player VALUES (1, 1001, 1, 1, 'Ahmed', 'GK', '1999-03-10', '0500000000'); 
INSERT INTO player VALUES (2, 1008, 1, 2, 'Khalid', 'DF', '1977-02-12', '0500000001'); 
INSERT INTO player VALUES (3, 1016, 1, 3, 'Saeed', 'MF', '1999-08-05','0500000002'); 
INSERT INTO player VALUES (4, 1007, 2, 1, 'Majid', 'GK', '1998-02-20', '0500000003'); 
INSERT INTO player VALUES (5, 1013, 2, 5, 'Fahd', 'MF', '1997-07-27', '0500000004'); 
INSERT INTO player VALUES (6, 1010, 2, 6, 'Mohammed', 'DF', '1992-11-20', '0500000005'); 
INSERT INTO player VALUES (7, 1004, 2, 7, 'Ali', 'DF', '1995-10-11', '0500000006');
INSERT INTO player VALUES (8, 1012, 2, 8, 'Raed', 'MF', '1997-01-05', '0500000007'); 
INSERT INTO player VALUES (9, 1017, 2, 9, 'Mousa', 'MF', '1996-12-17', '0500000008'); 
INSERT INTO player VALUES (10, 1023, 2, 1, 'Naeem', 'GK', '1991-05-27', '0500000009'); 
INSERT INTO player VALUES (11, 1022, 2, 4, 'Yasir', 'FD', '1998-07-15', '0500000010'); 
INSERT INTO player VALUES (12, 1003, 4, 2, 'Nasr', 'GK', '1997-09-25', '0500000011'); 
INSERT INTO player VALUES (13, 1015, 4, 13, 'Ashraf', 'MF', '1994-01-16', '0500000012'); 
INSERT INTO player VALUES (14, 1019, 6, 14, 'Hassan', 'MF', '1991-03-28', '0500000013'); 
INSERT INTO player VALUES (15, 1009, 6, 15, 'Abdullah', 'DF', '1996-06-09', '0500000014');
INSERT INTO player VALUES (16, 1021, 4, 16, 'Bassam', 'FD', '1999-07-27', '0500000015');

CREATE TABLE referee (
referee_id numeric NOT NULL,
referee_name varchar(40) NOT NULL,
PRIMARY KEY (referee_id) );

INSERT INTO referee VALUES (7001,'Hassan'); 
INSERT INTO referee VALUES (7002,'Robert'); 
INSERT INTO referee VALUES (7003,'Fayez'); 
INSERT INTO referee VALUES (7004, 'Mark'); 
INSERT INTO referee VALUES (7005,'Ahmad'); 
INSERT INTO referee VALUES (7006,'Faisal'); 
INSERT INTO referee VALUES (7007,'Noman');

CREATE TABLE match_played ( 
match_no numeric NOT NULL, 
play_stage char(1) NOT NULL, 
play_date date NOT NULL,
results char(5) NOT NULL, 
decided_by char(1) NOT NULL, 
goal_score char(5) NOT NULL,
venue_id numeric NOT NULL,
referee_id numeric NOT NULL, 
audience numeric NOT NULL, 
player_of_match serial NOT NULL, 
stop1_sec numeric NOT NULL, 
stop2_sec numeric NOT NULL,
PRIMARY KEY (match_no),
FOREIGN KEY (venue_id) REFERENCES venue (venue_id),
FOREIGN KEY (referee_id) REFERENCES referee (referee_id), 
FOREIGN KEY (player_of_match) REFERENCES player(player_uuid));


INSERT INTO match_played VALUES (1, 'G', '2020-03-11', 'WIN', 'N', '2-1', 11, 7001, 5113, 13, 131, 242); 
INSERT INTO match_played VALUES (2, 'G', '2020-03-11', 'DRAW', 'N', '1-1', 22, 7002 ,510, 12, 111, 272); 
INSERT INTO match_played VALUES (3, 'G', '2020-03-11', 'DRAW', 'N', '1-1', 33, 7002 ,510, 12, 111, 272); 
INSERT INTO match_played VALUES (4, 'G', '2020-03-11', 'DRAW', 'N', '1-1', 11, 7002 ,510, 12, 111, 272); 
INSERT INTO match_played VALUES (5, 'G', '2020-03-11', 'DRAW', 'N', '1-1', 44, 7002 ,510, 12, 111, 272); 
INSERT INTO match_played VALUES (6, 'G', '2020-03-11', 'DRAW', 'N', '1-1', 22, 7002 ,510, 12, 111, 272); 
INSERT INTO match_played VALUES (7, 'G', '2020-03-11', 'DRAW', 'N', '1-1', 33, 7002 ,510, 12, 111, 272);


CREATE TABLE coach (
coach_id numeric NOT NULL,
coach_name varchar(40) NOT NULL,
PRIMARY KEY (coach_id) );

INSERT INTO coach VALUES (9001,'Carlos'); 
INSERT INTO coach VALUES (9003,'Farhan'); 
INSERT INTO coach VALUES (9002,'Jameel');


CREATE TABLE asst_referee (
asst_ref_id numeric NOT NULL,
asst_ref_name varchar(40) NOT NULL,
PRIMARY KEY (asst_ref_id) );

INSERT INTO asst_referee VALUES (3001,'Ahmed'); 
INSERT INTO asst_referee VALUES (3003,'Saied'); 
INSERT INTO asst_referee VALUES (3002,'Fadhel'); 
INSERT INTO asst_referee VALUES (3004,'Morad'); 
INSERT INTO asst_referee VALUES (3005,'Farid');

CREATE TABLE match_details ( 
match_no numeric NOT NULL, 
play_stage char(1) NOT NULL, 
win_lose char(1) NOT NULL, 
decided_by char(1) NOT NULL, 
goal_score numeric NOT NULL, 
penalty_score numeric,
asst_ref numeric NOT NULL,
player_gk serial NOT NULL,
PRIMARY KEY (match_no, player_gk),
FOREIGN KEY (asst_ref) REFERENCES asst_referee (asst_ref_id),
FOREIGN KEY (player_gk) REFERENCES player (player_uuid),
FOREIGN KEY (match_no) REFERENCES match_played (match_no));

INSERT INTO match_details VALUES (1, 'G', 'W', 'N', 1, 0,3001,1); 
INSERT INTO match_details VALUES (2, 'G', 'W', 'N', 2, 0,3004,4); 
INSERT INTO match_details VALUES (2, 'G', 'L', 'N', 2, 0,3003,12); 
INSERT INTO match_details VALUES (1, 'G', 'L', 'N', 1, 0,3001,10); 
INSERT INTO match_details VALUES (3, 'G', 'W', 'N', 2, 0,3002,4); 


CREATE TABLE goal_details (
goal_id numeric NOT NULL,
match_no numeric NOT NULL,
player_id serial NOT NULL,
goal_time numeric NOT NULL, 
goal_type char(1) NOT NULL, 
play_stage char(1) NOT NULL, 
goal_schedule char(2) NOT NULL, 
goal_half numeric,
PRIMARY KEY (goal_id),
FOREIGN KEY (player_id) REFERENCES player (player_uuid),
FOREIGN KEY (match_no) REFERENCES match_played (match_no));

INSERT INTO goal_details VALUES (1, 1, 2, 72, 'N', 'G', 'NT', 2); 
INSERT INTO goal_details VALUES (2, 1, 5, 82, 'N', 'G', 'NT', 2); 
INSERT INTO goal_details VALUES (3, 1, 4, 72, 'N', 'G', 'NT', 2); 
INSERT INTO goal_details VALUES (4, 1, 7, 12, 'N', 'G', 'NT', 1); 
INSERT INTO goal_details VALUES (5, 1, 9, 15, 'N', 'G', 'NT', 1); 
INSERT INTO goal_details VALUES (6, 1, 14, 32, 'N', 'G', 'NT', 1);


CREATE TABLE penalty_shootout (
kick_id serial NOT NULL, 
match_no numeric NOT NULL,
player_id serial NOT NULL, 
score_goal char(1) NOT NULL, 
kick_no numeric NOT NULL,
PRIMARY KEY (kick_id),
FOREIGN KEY (player_id) REFERENCES player (player_uuid),
FOREIGN KEY (match_no) REFERENCES match_played (match_no));

INSERT INTO penalty_shootout VALUES (1, 1, 14, 'N', 1); 
INSERT INTO penalty_shootout VALUES (2, 5, 15, 'Y', 4);


CREATE TABLE player_booked ( 
match_no numeric NOT NULL, 
player_id serial NOT NULL, 
booking_time numeric NOT NULL, 
sent_off char(1),
play_schedule char(2) NOT NULL, 
play_half numeric NOT NULL,
PRIMARY KEY (match_no, player_id), 
FOREIGN KEY (player_id) REFERENCES player (player_uuid),
FOREIGN KEY (match_no) REFERENCES match_played (match_no));

INSERT INTO player_booked VALUES (1, 14, 36, 'N','NT', 1); 
INSERT INTO player_booked VALUES (1, 10, 76, 'Y','NT', 2);

CREATE TABLE player_in_out (
match_no numeric NOT NULL, 
player_id serial NOT NULL,
in_out char(1) NOT NULL, 
time_in_out numeric NOT NULL, 
play_schedule char(2) NOT NULL, 
play_half numeric NOT NULL,
PRIMARY KEY (match_no, player_id),
FOREIGN KEY (player_id) REFERENCES player (player_uuid),
FOREIGN KEY (match_no) REFERENCES match_played (match_no));


INSERT INTO player_in_out VALUES (1, 2, 'I', 73,'NT', 2); 
INSERT INTO player_in_out VALUES (2, 6, 'O', 33,'NT', 1);

CREATE TABLE match_captain (
match_no numeric NOT NULL, 
player_captain serial NOT NULL,
PRIMARY KEY (match_no, player_captain),
FOREIGN KEY (player_captain) REFERENCES player (player_uuid), 
FOREIGN KEY (match_no) REFERENCES match_played (match_no));
INSERT INTO match_captain VALUES (1, 1); 
INSERT INTO match_captain VALUES (2,4);

CREATE TABLE team_coaches ( 
team_tr serial NOT NULL,
coach_id numeric NOT NULL,
PRIMARY KEY (coach_id, team_tr),
FOREIGN KEY (team_tr) REFERENCES team (team_uuid), 
FOREIGN KEY (coach_id) REFERENCES coach (coach_id));

INSERT INTO team_coaches VALUES (1, 9001); 
INSERT INTO team_coaches VALUES (2, 9003);

CREATE TABLE penalty_gk ( 
match_no numeric NOT NULL, 
player_gk serial NOT NULL,
PRIMARY KEY (match_no,player_gk),
FOREIGN KEY (player_gk) REFERENCES player (player_uuid),
FOREIGN KEY (match_no) REFERENCES match_played (match_no));

INSERT INTO penalty_gk VALUES (1,1);
INSERT INTO penalty_gk VALUES (1,4);