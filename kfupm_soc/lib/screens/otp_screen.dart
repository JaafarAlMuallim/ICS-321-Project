// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/controllers/signup_controller.dart';
import 'package:kfupm_soc/misc/user.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../authentication_respository/authentication_repository.dart';

class OTPScreen extends StatefulWidget {
  // const OTPScreen({super.key, this.verificationId, this.phoneNum, this.user});
  const OTPScreen({super.key});
  // final String? verificationId;
  // final String? phoneNum;
  static String id = 'OTP';
  // final AppUser? user;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

// Back Arrow
class _OTPScreenState extends State<OTPScreen> {
  String otp = '';
  bool found = true;
  bool showSpinner = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  // getUser() async {
  //   // found = await AuthenticationRepository().findUser(widget.phoneNum!);
  // }

  @override
  void initState() {
    // getUser();
    super.initState();
  }

  // TODO Authenticate
  @override
  Widget build(BuildContext context) {
    final controller = OtpFieldController();
    return Scaffold(
      body: showSpinner
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Verification', style: Style.h1),
                      const SizedBox(height: 40),
                      const Text(
                        // 'We sent a verification code to ${widget.phoneNum}',
                        'We sent a verification code to XXXXXXXXXX',
                        style: Style.h4,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SvgPicture.asset(
                        "assets/svgs/otp.svg",
                        width: MediaQuery.of(context).size.width - 100,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      OTPTextField(
                        otpFieldStyle: OtpFieldStyle(
                            backgroundColor: const Color(0xff5B5959),
                            focusBorderColor: Colors.transparent),
                        length: 6,
                        spaceBetween: 13,
                        textFieldAlignment: MainAxisAlignment.center,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 53,
                        style: Style.otpStyle,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width - 450),
                        controller: controller,
                        fieldStyle: FieldStyle.box,
                        // onChanged: (value) => setState(() {
                        //       otp = value;
                        //     }),
                        // onCompleted: (pin) async {
                        //   var navigator = Navigator.of(context);
                        //   setState(() {
                        //     showSpinner = false;
                        //   });
                        //   bool verified = await AuthenticationRepository()
                        //       .verifyOTP(
                        //           pin, widget.verificationId!, context);
                        //   if (verified) {
                        //     if (!found) {
                        //       String x = await SignUpController().addDocument(
                        //           widget.user!.name!, widget.user!.phoneNum!);
                        //       if (x == 'Success') {
                        //         navigator
                        //             .popAndPushNamed(TournamentScreen.id);
                        //       } else {
                        //         ShowSnackBar.showSnackbar(
                        //             context, x, "", () {});
                        //       }
                        //     } else {
                        //       if (widget.user!.name != null) {
                        //         navigator
                        //             .popAndPushNamed(TournamentScreen.id);
                        //       } else {
                        //         ShowSnackBar.showSnackbar(context,
                        //             'Something went wrong', "", () {});
                        //         navigator.popAndPushNamed(LoginScreen.id);
                        //       }
                        //     }
                        //   } else {
                        //     controller.clear();
                        //     if (mounted) {
                        //       setState(() {
                        //         showSpinner = false;
                        //       });
                        //     }
                        //   }
                        // )},
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Didn't receive the code?",
                        style: Style.h4,
                      ),
                      TextButton(
                          onPressed: () {
                            //TODO Let the program send a code and make it unavailable for 30 seconds
                          },
                          child: Text(
                            "Send code",
                            style:
                                Style.h4.copyWith(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
