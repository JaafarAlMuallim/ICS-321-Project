import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/Core/fade_animation.dart';
import 'package:kfupm_soc/authentication_respository/authentication_repository.dart';
import 'package:kfupm_soc/widgets/rounded_button.dart';
import 'package:kfupm_soc/screens/register_screen.dart';
import 'package:kfupm_soc/screens/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color.fromARGB(255, 26, 37, 48);
  bool ispasswordev = true;

  TextEditingController phoneController = TextEditingController();

  static String phoneNum = '';

  @override
  Widget build(BuildContext context) {
    PhoneNumberInputController phonenumController =
        PhoneNumberInputController(context);
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                'https://e1.pxfuel.com/desktop-wallpaper/189/764/desktop-wallpaper-latest-iphone-x-football-aesthetic.jpg',
              ),
              colorFilter: ColorFilter.mode(
                const Color(0x0fffffff).withOpacity(0.2),
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
                            'assets/images/logo_transparent.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const FadeAnimation(
                          delay: 1,
                          child: Text(
                            'Please log in to continue',
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
                              color: backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            width: 300,
                            height: 90,
                            child: PhoneNumberInput(
                              controller: phonenumController,
                              searchHint: 'Search for country',
                              allowPickFromContacts: false,
                              errorText: 'Check phone number format',
                              initialCountry: 'SA',
                              locale: 'en',
                              countryListMode: CountryListMode.bottomSheet,
                              contactsPickerPosition:
                                  ContactsPickerPosition.suffix,
                              onChanged: (value) {
                                phoneNum = value;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeAnimation(
                          delay: 1,
                          child: Roundedbutton(
                            onPressed: (() {
                              AuthenticationRepository().phoneAuth(
                                  phoneNum: phoneNum, context: context);
                            }),
                            color: Colors.blue.shade600,
                            title: 'Login',
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
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, RegisterScreen.id);
                          },
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
              onPressed: () =>
                  Navigator.popAndPushNamed(context, WelcomeScreen.id),
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
