import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kfupm_soc/authentication_respository/authentication_repository.dart';
import 'package:kfupm_soc/screens/Login_screen.dart';
import 'package:kfupm_soc/screens/welcome_screen.dart';

import '../Core/fade_animation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Color enabled = const Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color.fromARGB(255, 26, 37, 48);
  bool ispasswordev = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController bdateController = TextEditingController();
  TextEditingController kfupmidController = TextEditingController();
  static String name = '';

  static String phoneNum = '';

  static String kfupmId = '';

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
                const Color(0x00ffffff).withOpacity(0.2),
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
              stops: const [0.1, 0.4, 0.7, 0.9],
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
                        FadeAnimation(
                          delay: 1,
                          child: Text(
                            'Create your account',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
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
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            width: 300,
                            height: 50,
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                hintText: 'Full Name',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.title,
                                  size: 20,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            width: 300,
                            height: 75,
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
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            width: 300,
                            height: 50,
                            child: TextField(
                              controller: kfupmidController,
                              decoration: const InputDecoration(
                                hintText: 'KFUPM ID',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.account_box_outlined,
                                  size: 20,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                kfupmId = value;
                              },
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
                            height: 50,
                            child: TextField(
                              readOnly: true,
                              controller: bdateController,
                              decoration: const InputDecoration(
                                hintText: 'Birth Date',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  size: 20,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {},
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2018),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    bdateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                            onPressed: () {
                              AuthenticationRepository().regAuth(
                                  name: name,
                                  phoneNum: phoneNum,
                                  kfupmId: kfupmId,
                                  bdate: bdateController.text,
                                  context: context);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF2697FF),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 80,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
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
                    height: 20,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'If you have an account ',
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
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
            backgroundColor: const Color(0xFF87CEEB).withOpacity(0),
          ),
        ),
      ]),
    );
  }
}
