// import 'package:kfupm_soc/misc/models/screen_model.dart';
// import 'package:kfupm_soc/screens/matches_screen.dart';
// import 'package:kfupm_soc/screens/profile_screen.dart';
// import 'package:kfupm_soc/screens/requests_screen.dart';
// import 'package:kfupm_soc/screens/teams_screen.dart';
// import 'package:kfupm_soc/screens/tournaments_screen.dart';
// import 'package:kfupm_soc/screens/welcome_screen.dart';

// class ScreenVm {
//   static final List<ScreenModel> screenList = [
//     ScreenModel(title: 'Welcome', screen: const WelcomeScreen()),
//     ScreenModel(
//       title: 'Tournaments',
//       screen: const TournamentScreen(),
//     ),
//     ScreenModel(
//       title: 'Teams',
//       screen: const TeamScreen(),
//     ),
//     ScreenModel(
//       title: 'Schedule',
//       screen: const MatchesScreen(),
//     ),
//     ScreenModel(
//       title: 'Requests',
//       screen: const RequestsScreen(),
//     ),
//     ScreenModel(
//       title: 'Profile',
//       screen: const ProfileScreen(),
//     ),
//   ];

//   static void selectScreen(int index) {
//     for (int i = 0; i < screenList.length; i++) {
//       if (i == index) {
//         screenList[i] = screenList[i].copyWith(selected: true);
//       } else {
//         screenList[i] = screenList[i].copyWith(selected: false);
//       }
//     }
//   }
// }
