import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/misc/user.dart';
import 'package:kfupm_soc/screens/otp_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String verificationID = '';
  get getVerificationID => verificationID;

  set setVerificationID(String verificationID) =>
      this.verificationID = verificationID;

  Future<String> documentUserinFireStore(String name, String phoneNum) async {
    try {
      Future.delayed(const Duration(seconds: 4));
      await _fireStore.collection('Users').doc(_auth.currentUser!.uid).set({
        'name': name,
        'phoneNumber': phoneNum,
        'schedule': [],
      });
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> phoneAuth(
      {String? name,
      String? uni,
      required String phoneNum,
      String? gender,
      required BuildContext context}) async {
    AppUser user = AppUser(
      name: name,
      phoneNum: phoneNum,
    );
    bool isUser = await findUser(phoneNum);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNum,
      verificationCompleted: (phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
      },
      codeSent: (verificationId, forceResendingToken) {
        if (!isUser) {
          ShowSnackBar.showSnackbar(
              context, "This Phone number is not registered", "Register", () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pop(context);
            Navigator.pushNamed(context, RegisterScreen.id);
          });
        } else {
          verificationID = verificationId;
          verificationID = verificationId;
          // TODO UNcomment Later
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => OTPScreen(
          //       phoneNum: phoneNum,
          //       verificationId: verificationID,
          //       user: user,
          //     ),
          //   ),
          // );
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationID = verificationId;
      },
      verificationFailed: (error) {
        if (error.code == 'invalid-phone-number') {
          ShowSnackBar.showSnackbar(context, 'Invalid Phone Number', "", () {});
        } else {
          ShowSnackBar.showSnackbar(context, 'Something went wrong', "", () {});
        }
      },
    );
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
      });
      return false;
    }
  }

  Future<void> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      ShowSnackBar.showSnackbar(context, e.message, "", () {});
    } catch (e) {
      ShowSnackBar.showSnackbar(context, 'Something went wrong', "", () {});
    }
  }

  Future<bool> findUser(String phoneNum) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await _fireStore
          .collection('Users')
          .where('phoneNumber', isEqualTo: phoneNum)
          .get();
      print(phoneNum);
      print(data.docs.first);
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
