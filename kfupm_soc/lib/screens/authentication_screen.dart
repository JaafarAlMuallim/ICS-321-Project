import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kfupm_soc/Core/fade_animation.dart';

class AuthenticationScreen extends StatefulWidget {
  static const String id = 'authentication_screen';

  const AuthenticationScreen({super.key});
  @override
  State<AuthenticationScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthenticationScreen> {
  Color enabled = const Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color.fromARGB(255, 26, 37, 48);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController otpController = TextEditingController();

  String verify = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                'https://e1.pxfuel.com/desktop-wallpaper/189/764/desktop-wallpaper-latest-iphone-x-football-aesthetic.jpg',
              ),
              colorFilter: ColorFilter.mode(
                const Color(0x000fffff).withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0XFF527aaf).withOpacity(0.8),
                const Color(0XFF527aaf),
                const Color(0XFF031a38),
                const Color(0XFF031a38),
              ],
              stops: const [
                0.1,
                0.4,
                0.7,
                0.9,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: const Color.fromARGB(255, 171, 211, 250)
                        .withOpacity(0.4),
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(40.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: 400,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.asset(
                            'images/logo_transparent.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const FadeAnimation(
                          delay: 1,
                          child: Text(
                            'Please enter the code sent to your phone',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: selected == FormData.otp
                                  ? enabled
                                  : backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            width: 300,
                            height: 40,
                            child: TextField(
                              controller: otpController,
                              decoration: InputDecoration(
                                hintText: 'OTP',
                                hintStyle: TextStyle(
                                  color: selected == FormData.otp
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.message_outlined,
                                  size: 20,
                                  color: selected == FormData.otp
                                      ? enabledtxt
                                      : deaible,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: selected == FormData.otp
                                    ? enabledtxt
                                    : deaible,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                verify = value;
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.otp;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF2697FF),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 80,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
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
                        const Text(
                          "Didn't recieve code? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            'Send Again',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          right: 0.0,
          child: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: const Text(''),
            elevation: 0.0,
            backgroundColor: const Color(0xFF87CEEB).withOpacity(0.0),
          ),
        ),
      ]),
    );
  }
}

class CommonUtils {
  static String verify = '';

  static Future<String> firebasePhoneAuth({
    required String phone,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          print('Phone credentials $credential');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed $e');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Verification Failed! Try after some time.'),
          ));
        },
        codeSent: (String verificationId, int? resendToken) async {
          CommonUtils.verify = verificationId;
          print('Verify: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return CommonUtils.verify;
    } catch (e) {
      print('Exception $e');
      return '';
    }
  }
}

enum FormData {
  otp,
}
