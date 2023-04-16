import 'package:flutter/material.dart';

import 'package:kfupm_soc/screens/Login_screen.dart';

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

  FormData? selected;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bdateController = TextEditingController();
  TextEditingController kfupmidController = TextEditingController();

  static String fullname = '';

  static String phonenum = '';

  static String email = '';

  static String kfupmid = '';

  static String bdate = '';

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
                            'images/logo_transparent.png',
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
                              color: selected == FormData.name
                                  ? enabled
                                  : backgroundColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            width: 300,
                            height: 40,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                hintStyle: TextStyle(
                                  color: selected == FormData.name
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.title,
                                  size: 20,
                                  color: selected == FormData.name
                                      ? enabledtxt
                                      : deaible,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: selected == FormData.name
                                    ? enabledtxt
                                    : deaible,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                fullname = value;
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.name;
                                });
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
                              color: selected == FormData.phone
                                  ? enabled
                                  : backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            width: 300,
                            height: 40,
                            child: TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  color: selected == FormData.phone
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.phone_android_rounded,
                                  size: 20,
                                  color: selected == FormData.phone
                                      ? enabledtxt
                                      : deaible,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: selected == FormData.phone
                                    ? enabledtxt
                                    : deaible,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                phonenum = value;
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.phone;
                                });
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
                              color: selected == FormData.email
                                  ? enabled
                                  : backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            width: 300,
                            height: 40,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: selected == FormData.email
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: 20,
                                  color: selected == FormData.email
                                      ? enabledtxt
                                      : deaible,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: selected == FormData.email
                                    ? enabledtxt
                                    : deaible,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                email = value;
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.email;
                                });
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
                              color: selected == FormData.kfupmId
                                  ? enabled
                                  : backgroundColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            width: 300,
                            height: 40,
                            child: TextField(
                              controller: kfupmidController,
                              decoration: InputDecoration(
                                hintText: 'KFUPM ID',
                                hintStyle: TextStyle(
                                  color: selected == FormData.kfupmId
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.account_box_outlined,
                                  size: 20,
                                  color: selected == FormData.kfupmId
                                      ? enabledtxt
                                      : deaible,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: selected == FormData.kfupmId
                                    ? enabledtxt
                                    : deaible,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                kfupmid = value;
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.kfupmId;
                                });
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
                              color: selected == FormData.bdate
                                  ? enabled
                                  : backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            width: 300,
                            height: 40,
                            child: TextField(
                              controller: bdateController,
                              decoration: InputDecoration(
                                hintText: 'Birth Date',
                                hintStyle: TextStyle(
                                  color: selected == FormData.bdate
                                      ? enabledtxt
                                      : deaible,
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  size: 20,
                                  color: selected == FormData.bdate
                                      ? enabledtxt
                                      : deaible,
                                ),
                                enabledBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(
                                color: selected == FormData.bdate
                                    ? enabledtxt
                                    : deaible,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                bdate = value;
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.bdate;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
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
              onPressed: () => Navigator.of(context).pop(),
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

enum FormData {
  name,
  phone,
  email,
  kfupmId,
  bdate,
}
