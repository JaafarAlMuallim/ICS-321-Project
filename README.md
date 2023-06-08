# ICS-321-Project - KFUPMSOC

KFUPMSOC is a tournament manager for KFUPM soccer tournaments that is used by

*1- admins:*
- Create new tournaments
- Delete tournaments
- Approve teams to join tournaments
- Approve players to join teams
- Generate teams tables after tournament registeration time.
- Select Manager, coach, and captain for the team

*2- members:*
- Request to join team
- Request to join tournament (if the member is captain or manager only).
- Request to form new team.
- View request history and its status.

*3- Guests, members, admins:*
- Broswe all tournaments, matches and their results sorted by date.
- Browse some statistics such as highest scored goals across all tournaments, players who received red cards across all tournaments, and the highest number of MVPs across all tournaments.

### Tech
 
 - HTML / CSS / JS
 - Express 
 - Dart / Flutter
 - Supabase / Firebase


 ### Running the applications
 - `git clone https://github.com/JaafarAlMuallim/ICS-321-Project.git`

 ####  To run the web application (admins side)
in the folder that was cloned and with the correct environment setting
- `cd kfupmSoc`
- `npm i`
- `nodemon app.js`

 ####  To run the mobile application (members and guests side)
in the folder that was cloned and with the correct environment setting
- `cd kfupm_soc`
- `flutter pub get`
- `flutter run`


 




