import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_soc/Core/fade_animation.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/welcome_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';

final _auth = FirebaseAuth.instance;
final _db = FirebaseFirestore.instance;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String id = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loading = true;
  String name = 'GUEST';
  bool loggedIn = false;
  DocumentSnapshot? doc;
  getUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final docRef = _db.collection('Users').doc(user.uid);
      doc = await docRef.get();
      // TODO serach for coachings and playing carrer in supabase base.
      setState(() {
        name = doc!['name'];
        loggedIn = true;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  logout() {
    BottomNavBar.reset();
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Text(
              'Profile',
              style: Style.kSubtitleStyle,
            ),
          ),
          elevation: 0,
          backgroundColor: CustomColors.navy,
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
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
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : FadeAnimation(
                      delay: 0.6,
                      child: Center(
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              loggedIn
                                  ? IconButton(
                                      iconSize: 45,
                                      color: Colors.white,
                                      icon: const Icon(Icons.logout),
                                      onPressed: () {
                                        _auth.signOut();
                                        logout();
                                      },
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        logout();
                                      },
                                      icon: const Icon(Icons.login),
                                      color: Colors.white,
                                      iconSize: 45),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/default.png'),
                              backgroundColor: Colors.blue,
                              radius: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            name,
                            style: Style.h3,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ]),
                      ),
                    ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
