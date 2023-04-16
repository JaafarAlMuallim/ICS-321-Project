import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';

import '../../Core/Animation/Fade_Animation.dart';
import '../../Core/Colors/Hex_Color.dart';
import 'package:kfupm_soc/screens/Login_screen.dart';

enum FormData {
  otp,
}

class AuthenticationScreen extends StatefulWidget {
  @override
  static const String id = 'authentication_screen';
  State<AuthenticationScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthenticationScreen> {
  Color enabled = Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = Color.fromARGB(255, 26, 37, 48);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController otpController = new TextEditingController();

  String verify = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.4, 0.7, 0.9],
              colors: [
                HexColor("#527aaf").withOpacity(0.8),
                HexColor("#527aaf"),
                HexColor("#031a38"),
                HexColor("#031a38")
              ],
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
              image: const NetworkImage(
                'https://e1.pxfuel.com/desktop-wallpaper/189/764/desktop-wallpaper-latest-iphone-x-football-aesthetic.jpg',
              ),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    color: const Color.fromARGB(255, 171, 211, 250)
                        .withOpacity(0.4),
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeAnimation(
                            delay: 0.8,
                            child: Image.asset(
                              'images/logo_transparent.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: const Text(
                              "Please enter the code sent to your phone",
                              style: TextStyle(
                                  color: Colors.white, letterSpacing: 0.5),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              width: 300,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: selected == FormData.otp
                                    ? enabled
                                    : backgroundColor,
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  verify = value;
                                },
                                controller: otpController,
                                onTap: () {
                                  setState(() {
                                    selected = FormData.otp;
                                  });
                                },
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.message_outlined,
                                    color: selected == FormData.otp
                                        ? enabledtxt
                                        : deaible,
                                    size: 20,
                                  ),
                                  hintText: 'OTP',
                                  hintStyle: TextStyle(
                                      color: selected == FormData.otp
                                          ? enabledtxt
                                          : deaible,
                                      fontSize: 12),
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    color: selected == FormData.otp
                                        ? enabledtxt
                                        : deaible,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (context) {
                                  //   return MyApp(isLogin: true);
                                  // }));
                                },
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF2697FF),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)))),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //End of Center Card
                  //Start of outer card
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Didn't recieve code? ",
                            style: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            )),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   return RegisterScreen();
                            // }));
                          },
                          child: Text("Send Again",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: Text(''), // You can add title here
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Color(0xFF87CEEB)
                .withOpacity(0.0), //You can make this transparent
            elevation: 0.0, //No shadow
          ),
        ),
      ]),
    );
  }
}

class CommonUtils {
  static String verify = "";

  static Future<String> firebasePhoneAuth(
      {required String phone, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          print("Phone credentials $credential");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed $e");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Verification Failed! Try after some time.")));
        },
        codeSent: (String verificationId, int? resendToken) async {
          CommonUtils.verify = verificationId;
          print("Verify: $verificationId");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return CommonUtils.verify;
    } catch (e) {
      print("Exception $e");
      return "";
    }
  }
}
