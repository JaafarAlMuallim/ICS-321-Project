// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/misc/user.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/otp_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String verificationID = '';
  get getVerificationID => verificationID;

  set setVerificationID(String verificationID) =>
      this.verificationID = verificationID;

  Future<String> documentUserinFireStore(
      String name, String phoneNum, String kfupmId, String bdate) async {
    List<dynamic> data = [];
    try {
      data = await supabase.from("member").insert({
        'name': name,
        'bdate': bdate,
        'kfupm_id': kfupmId,
        'phone_num': phoneNum,
      }).select();
      Future.delayed(const Duration(seconds: 4));
      await _fireStore.collection('Users').doc(data[0]['member_uuid']).set({
        'name': name,
        'phoneNumber': phoneNum,
        'kfupmId': kfupmId,
        'bdate': bdate,
      });
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> regAuth(
      {required String name,
      required String phoneNum,
      required String kfupmId,
      required String bdate,
      required BuildContext context}) async {
    bool isUser = await findUser(phoneNum);
    AppUser user =
        AppUser(name: name, phoneNum: phoneNum, kfupmId: kfupmId, bdate: bdate);
    if (isUser) {
      ShowSnackBar.showSnackbar(context, "Already Registered", "Login", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.pop(context);
        Navigator.pushNamed(context, LoginScreen.id);
      }, Style.containerColor);
    } else {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNum,
          verificationCompleted: (PhoneAuthCredential cradential) async =>
              await _auth.signInWithCredential(cradential),
          verificationFailed: (error) {
            if (error.code == 'invalid-phone-number') {
              ShowSnackBar.showSnackbar(context, 'Invalid Phone Number', "",
                  () {}, Style.containerColor);
            } else {
              ShowSnackBar.showSnackbar(
                  context, error.message, "", () {}, Style.containerColor);
            }
          },
          codeSent: (verificationId, forceResendingToken) {
            verificationID = verificationId;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                    phoneNum: phoneNum,
                    verificationId: verificationID,
                    user: user),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {
            verificationID = verificationId;
          });
    }
  }

  Future<void> phoneAuth(
      {String? name,
      required String phoneNum,
      String? kfupmId,
      DateTime? bdate,
      required BuildContext context}) async {
    AppUser user = AppUser(phoneNum: phoneNum);
    bool isUser = await findUser(phoneNum);
    if (!isUser) {
      ShowSnackBar.showSnackbar(
          context, "This Phone number is not Registered", "Register", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.pop(context);
        Navigator.pushNamed(context, RegisterScreen.id);
      }, Style.containerColor);
    } else {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNum,
          verificationCompleted: (PhoneAuthCredential cradential) async =>
              await _auth.signInWithCredential(cradential),
          verificationFailed: (error) {
            if (error.code == 'invalid-phone-number') {
              ShowSnackBar.showSnackbar(context, 'Invalid Phone Number', "",
                  () {}, Style.containerColor);
            } else {
              ShowSnackBar.showSnackbar(
                  context, error.message, "", () {}, Style.containerColor);
            }
          },
          codeSent: (verificationId, forceResendingToken) {
            verificationID = verificationId;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                    phoneNum: phoneNum,
                    verificationId: verificationID,
                    user: user),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {
            verificationID = verificationId;
          });
    }
  }

  Future<bool> verifyOTP(
      String otp, String verificationId, BuildContext context) async {
    try {
      UserCredential credential = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));
      return credential.user != null ? true : false;
    } catch (e) {
      ShowSnackBar.showSnackbar(context, "Wrong OTP!", "Got it!", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }, Style.containerColor);
      return false;
    }
  }

  Future<void> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      ShowSnackBar.showSnackbar(
          context, e.message, "", () {}, Style.containerColor);
    } catch (e) {
      ShowSnackBar.showSnackbar(
          context, 'Something went wrong', "", () {}, Style.containerColor);
    }
  }

  Future<bool> findUser(String phoneNum) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await _fireStore
          .collection('Users')
          .where('phoneNumber', isEqualTo: phoneNum)
          .get();
      if (data.docs.first.exists) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
