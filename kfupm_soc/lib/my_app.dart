import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kfupm_soc/screens/Login_screen.dart';
import 'package:kfupm_soc/screens/create_team_screen.dart';
import 'package:kfupm_soc/screens/join_team_screen.dart';
import 'package:kfupm_soc/screens/join_tournament_screen.dart';
import 'package:kfupm_soc/screens/matches_screen.dart';
import 'package:kfupm_soc/screens/otp_screen.dart';
import 'package:kfupm_soc/screens/profile_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';
import 'package:kfupm_soc/screens/request_history_screen.dart';
import 'package:kfupm_soc/screens/requests_screen.dart';
import 'package:kfupm_soc/screens/stats_screen.dart';
import 'package:kfupm_soc/screens/teams_screen.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/screens/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        OTPScreen.id: (context) => const OTPScreen(),
        TournamentScreen.id: (context) => const TournamentScreen(),
        // TournamentInfoScreen.id: (context) =>
        //     const TournamentInfoScreen(tournamentId: 'x'),
        TeamScreen.id: (context) => const TeamScreen(),
        MatchesScreen.id: (context) => const MatchesScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        RequestsScreen.id: (context) => const RequestsScreen(),
        StatsticsScreen.id: (context) => const StatsticsScreen(),
        JoinTeamScreen.id: (context) => const JoinTeamScreen(),
        JoinTournamentScreen.id: (context) => const JoinTournamentScreen(),
        RequestHistoryScreen.id: (context) => const RequestHistoryScreen(),
        CreateTeamScreen.id: (context) => const CreateTeamScreen()
      },
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen.id
          : TournamentScreen.id,
      title: 'KFUPMSOC',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: Colors.white,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Color.fromARGB(255, 39, 128, 176),
      //   ),
      //   canvasColor: const Color.fromARGB(255, 39, 128, 176),
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Style.kActiveButton,
      //     onPrimary: Style.kBottomBar,
      //     secondary: Style.kNameContainer,
      //     onSecondary: Style.kButtonText,
      //     error: Colors.red,
      //     onError: Style.kPressedCard,
      //     background: Color.fromARGB(255, 39, 128, 176),
      //     onBackground: Style.kBackgroundBlurred,
      //     surface: Style.kIconColor,
      //     onSurface: Style.kInActivated,
      //   ),
      // ),
      theme: ThemeData.dark().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xff222121),
      ),
    );
  }
}
