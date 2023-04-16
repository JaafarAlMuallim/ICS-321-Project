// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:kfupm_soc/widgets/rounded_button.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';

import '../Core/fade_animation.dart';

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
      upperBound: 1,
      vsync: this,
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
      body: FadeAnimation(
        delay: 0.8,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                'https://t3.ftcdn.net/jpg/03/55/60/70/360_F_355607062_zYMS8jaz4SfoykpWz5oViRVKL32IabTP.jpg',
              ),
              colorFilter: ColorFilter.mode(
                Color(0x00000fff).withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0XFF527aaf).withOpacity(0.8),
                Color(0XFF527aaf),
                Color(0XFF031a38),
                Color(0XFF031a38),
              ],
              stops: const [
                0.1,
                0.4,
                0.7,
                0.9,
              ],
            ),
          ),
          child: FadeAnimation(
            delay: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
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
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '   KFUPMSOC',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: Duration(milliseconds: 150),
                      ),
                    ],
                    pause: Duration(milliseconds: 1000),
                    repeatForever: true,
                  ),
                ]),
                SizedBox(height: 48.0),
                Roundedbutton(
                  color: Colors.blue.shade400,
                  onPressed: (() =>
                      Navigator.pushNamed(context, LoginScreen.id)),
                  title: 'Log In',
                ),
                Roundedbutton(
                  color: Colors.blue.shade800,
                  onPressed: (() =>
                      Navigator.pushNamed(context, RegisterScreen.id)),
                  title: 'Register',
                ),
                Roundedbutton(
                  color: Colors.blue.shade900,
                  onPressed: (() {}),
                  title: 'Guest',
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
