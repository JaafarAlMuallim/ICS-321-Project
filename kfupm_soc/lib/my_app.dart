import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/Login_screen.dart';
import 'package:kfupm_soc/screens/otp_screen.dart';
import 'package:kfupm_soc/screens/register_screen.dart';
import 'package:kfupm_soc/screens/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        OTPScreen.id: (context) => const OTPScreen(),
      },
      initialRoute: WelcomeScreen.id,
      title: 'KFUPMSOC',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: Colors.white,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Color.fromARGB(255, 39, 128, 176),
      //   ),
      //   canvasColor: const Color.fromARGB(255, 39, 128, 176),
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Style.kActiveButton,
      //     onPrimary: Style.kBottomBar,
      //     secondary: Style.kNameContainer,
      //     onSecondary: Style.kButtonText,
      //     error: Colors.red,
      //     onError: Style.kPressedCard,
      //     background: Color.fromARGB(255, 39, 128, 176),
      //     onBackground: Style.kBackgroundBlurred,
      //     surface: Style.kIconColor,
      //     onSurface: Style.kInActivated,
      //   ),
      // ),
      theme: ThemeData.dark().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xff222121),
      ),
    );
  }
}
