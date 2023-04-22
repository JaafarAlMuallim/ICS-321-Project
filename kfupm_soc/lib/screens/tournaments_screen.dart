import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';

final _auth = FirebaseAuth.instance;

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});
  static const id = 'tournament';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // text button for sign out
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF2697FF),
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 80,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            onPressed: () {
              try {
                _auth.signOut();
                Navigator.popAndPushNamed(context, LoginScreen.id);
                ShowSnackBar.showSnackbar(context, 'Sign Out Succesfully', '',
                    () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }, Colors.green);
              } on FirebaseException catch (e) {
                ShowSnackBar.showSnackbar(context, e.message, "Sign Out", () {
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }, Style.containerColor);
              }
            },
            child: const Text(
              'Sign Out',
              style: Style.kTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
