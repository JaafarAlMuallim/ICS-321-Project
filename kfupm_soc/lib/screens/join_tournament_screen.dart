// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kfupm_soc/screens/requests_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Core/fade_animation.dart';

final supabase = Supabase.instance.client;

class JoinTournamentScreen extends StatefulWidget {
  const JoinTournamentScreen({super.key});
  static const String id = 'join_tournament_screen';

  @override
  State<JoinTournamentScreen> createState() => _JoinTournamentScreenState();
}

class _JoinTournamentScreenState extends State<JoinTournamentScreen> {
  Color enabled = const Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color.fromARGB(255, 26, 37, 48);

  TextEditingController positionController = TextEditingController();
  TextEditingController jerseyNumberController = TextEditingController();
  TextEditingController tournamentController = TextEditingController();
  List<dynamic> data = [];
  // List<String> pos = ['GK', 'DF', 'MF', 'FD'];
  int? selectedTournament;

  fetchData() async {
    data = await supabase.from('tournament').select('*');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // Check if user is authenticated.
  insertData(String trId, String position, int jerseyNo) async {
    // await supabase.from("player").insert({
    //   'member_uuid': memberUuid,
    //   'tr_id': trId,
    //   'position': position,
    //   'jersey_no': jerseyNo,
    //   'approved': false
    // });
    // TODO insert in team with default value of no group (make it nullable) and integers should be 0 approved is pending
  }

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
                            'assets/images/logo_transparent.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FadeAnimation(
                          delay: 1,
                          child: Text(
                            'Choose tournament',
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
                              decoration: InputDecoration(
                                labelText: 'Choose tournament',
                                hintText: 'Choose tournament',
                                border: const OutlineInputBorder(),
                                // TODO dropdown menu builder
                                // suffixIcon: DropdownButtonFormField(
                                //   value: selectedTournament,
                                //   onChanged: (newValue) {
                                //     setState(() {
                                //       selectedTournament = newValue;
                                //     });
                                //   },
                                //   items: data.map<DropdownMenuItem<dynamic>>(
                                //       (dynamic value) {
                                //     return DropdownMenuItem<dynamic>(
                                //       value: value,
                                //       child: Text(
                                //         value as String,
                                //         style: const TextStyle(fontSize: 16),
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                            onPressed: () {
                              // insertData();
                              // TODO no empty blocks
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
                              'Join',
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
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const RequestsScreen();
                }));
              },
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