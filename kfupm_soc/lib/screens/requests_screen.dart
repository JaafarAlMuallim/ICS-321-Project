// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/Core/fade_animation.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/join_team_screen.dart';
import 'package:kfupm_soc/screens/join_tournament_screen.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/request_history_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/rounded_button.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';

final _auth = FirebaseAuth.instance;

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});
  static const String id = 'requests';

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 5, top: 5),
          child: Text(
            'Requests',
            style: Style.kSubtitleStyle,
          ),
        ),
        elevation: 0,
        backgroundColor: CustomColors.navy,
        centerTitle: true,
      ),
      body: FadeAnimation(
        delay: 0.8,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                'https://t3.ftcdn.net/jpg/03/55/60/70/360_F_355607062_zYMS8jaz4SfoykpWz5oViRVKL32IabTP.jpg',
              ),
              colorFilter: ColorFilter.mode(
                Color(0x00000fff).withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0XFF527aaf).withOpacity(0.8),
                Color(0XFF527aaf),
                Color(0XFF031a38),
                Color(0XFF031a38),
              ],
              stops: const [
                0.1,
                0.4,
                0.7,
                0.9,
              ],
            ),
          ),
          child: FadeAnimation(
            delay: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 48.0),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Roundedbutton(
                    color: Colors.blue.shade400,
                    onPressed: () {
                      if (_auth.currentUser != null) {
                        Navigator.pushNamed(context, JoinTournamentScreen.id);
                      } else {
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                        ShowSnackBar.showSnackbar(
                            context, "Login to join tournament", "Login", () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }, Colors.orange[700]);
                      }
                    },
                    title: '+ Join tournament',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Roundedbutton(
                    color: Colors.blue.shade800,
                    onPressed: () {
                      if (_auth.currentUser != null) {
                        Navigator.pushNamed(context, JoinTeamScreen.id);
                      } else {
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                        ShowSnackBar.showSnackbar(
                            context, "Login to join a team", "Login", () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }, Colors.orange[700]);
                      }
                    },
                    title: '+ Join team',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Roundedbutton(
                    color: Colors.blue.shade800,
                    onPressed: () {
                      if (_auth.currentUser != null) {
                        Navigator.pushNamed(context, RequestHistoryScreen.id);
                      } else {
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                        ShowSnackBar.showSnackbar(context,
                            "Login to show your requests history", "Login", () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }, Colors.orange[700]);
                      }
                    },
                    title: '+ Show my history',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
