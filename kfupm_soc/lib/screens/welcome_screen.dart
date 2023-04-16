// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:kfupm_soc/components/rounded_button.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';

import '../Core/Colors/Hex_Color.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 1,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: animation.value,
      body: Container(
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
            image: AssetImage(
              'images/welcomebkg.jpg',
            ) as ImageProvider,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 60.0,
                      child: Image.asset('images/logo_transparent.png'),
                    ),
                  ),
                ),
                AnimatedTextKit(
                    pause: Duration(milliseconds: 1000),
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '   KFUPMSOC',
                        textStyle: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                        speed: Duration(milliseconds: 150),
                      )
                    ]),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Roundedbutton(
              color: Colors.blue.shade400,
              title: 'Log In',
              onPressed: (() => Navigator.pushNamed(context, LoginScreen.id)),
            ),
            Roundedbutton(
              color: Colors.blue.shade800,
              title: 'Register',
              onPressed: (() =>
                  Navigator.pushNamed(context, RegisterScreen.id)),
            ),
          ],
        ),
      ),
    );
  }
}
