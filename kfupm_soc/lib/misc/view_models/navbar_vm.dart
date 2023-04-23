// import 'package:flutter/material.dart';
// import 'package:kfupm_soc/misc/models/navbar_model.dart';
// import 'package:kfupm_soc/screens/matches_screen.dart';
// import 'package:kfupm_soc/screens/profile_screen.dart';
// import 'package:kfupm_soc/screens/requests_screen.dart';
// import 'package:kfupm_soc/screens/teams_screen.dart';
// import 'package:kfupm_soc/screens/tournaments_screen.dart';

// class NavbarItemVm {
//   static final List<NavbarItemModel> itemsList = [
//     NavbarItemModel(
//         label: 'Tournaments',
//         icon: const Icon(
//           Icons.tour,
//         ),
//         screen: TournamentScreen.id,
//         selected: true),
//     NavbarItemModel(
//       label: 'Teams',
//       icon: const Icon(
//         Icons.group_rounded,
//       ),
//       screen: TeamScreen.id,
//     ),
//     NavbarItemModel(
//       label: 'Schedule',
//       icon: const Icon(
//         Icons.date_range,
//       ),
//       screen: MatchesScreen.id,
//     ),
//     NavbarItemModel(
//       label: 'Requests',
//       icon: const Icon(
//         Icons.request_page,
//       ),
//       screen: RequestsScreen.id,
//     ),
//     NavbarItemModel(
//       label: 'Profile',
//       icon: const Icon(
//         Icons.portrait_rounded,
//       ),
//       screen: ProfileScreen.id,
//     ),
//   ];

//   static void selectScreen(int index) {
//     for (int i = 0; i < itemsList.length; i++) {
//       if (i == index) {
//         itemsList[i] = itemsList[i].copyWith(null, null, Icon, true);
//       } else {
//         itemsList[i] = itemsList[i].copyWith(selected: false);
//       }
//     }
//   }
// }
