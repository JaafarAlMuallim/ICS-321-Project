import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:kfupm_soc/constants.dart';
// import 'package:kfupm_soc/screens/home_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/profile_screen.dart';
import 'package:kfupm_soc/screens/welcome_screen.dart';
// import 'firebase_options.dart';
import 'package:kfupm_soc/screens/register_screen.dart';

void main() {
  // await dotenv.load(fileName: ".env");
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KFUPMSOC',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 39, 128, 176),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 39, 128, 176)),
        canvasColor: Color.fromARGB(255, 39, 128, 176),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        // MapScreen.id: (context) => const MapScreen(),
        // ProfileScreen.id: (context) => const ProfileScreen(),
        // HomeScreen.id: (context) => const HomeScreen(),
        // QuestionScreen.id: (context) => const QuestionScreen()
      },
    );
  }
}
