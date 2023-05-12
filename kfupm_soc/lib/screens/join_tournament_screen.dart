// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:kfupm_soc/screens/login_screen.dart';
import 'package:kfupm_soc/screens/request_history_screen.dart';
import 'package:kfupm_soc/screens/requests_screen.dart';
import 'package:kfupm_soc/widgets/rounded_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Core/fade_animation.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';

final supabase = Supabase.instance.client;
final _auth = fire.FirebaseAuth.instance;

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

  TextEditingController teamController = TextEditingController();
  TextEditingController tournamentController = TextEditingController();
  List<dynamic> userData = [];
  List<dynamic> data = [];
  List<dynamic> dataTeams = [];
  List<dynamic> dataTournaments = [];
  List<dynamic> managersData = [];
  String? selectedTeam;
  String? selectedTournament;
  bool _loading = true;
  String playerUuid = '';

  fetchData() async {
    fire.User? user = _auth.currentUser;
    if (user != null) {
      userData = await supabase
          .from('member')
          .select('*')
          .eq('phone_num', user.phoneNumber);

      setState(() {
        playerUuid = userData[0]['member_uuid'];
      });
      data = await supabase
          .from('team_captain')
          .select("*")
          .eq("member_uuid", playerUuid);
      List<String> teamUuids = [];
      List<dynamic> teamManager = await supabase
          .from('registered_team')
          .select('*')
          .eq('created_by', playerUuid);
      for (dynamic team in data) {
        teamUuids.add(team['team_uuid']);
      }
      for (dynamic manager in teamManager) {
        teamUuids.add(manager['team_uuid']);
      }
      List<dynamic> resTeam = await supabase
          .from('registered_team')
          .select('team_name')
          .in_('team_uuid', teamUuids);
      setState(() {
        dataTeams = resTeam;
      });
      List<dynamic> resTour = await supabase.from('tournament').select('*');
      setState(() {
        dataTournaments = resTour;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // Check if user is authenticated.
  Future<bool> insertData(String trName, String teamName) async {
    List<dynamic> teams = await supabase
        .from('registered_team')
        .select()
        .eq('team_name', teamName);

    List<dynamic> tournaments =
        await supabase.from('tournament').select().eq('tr_name', trName);

    List<dynamic> record = await supabase
        .from('team')
        .select('*')
        .eq('team_uuid', teams[0]['team_uuid'])
        .eq('tr_id', tournaments[0]['tr_id']);
    if (record.isNotEmpty) {
      return false;
    } else {
      List<dynamic> counter = await supabase.from('team').select('team_id');

      await supabase.from('team').upsert({
        'team_uuid': teams[0]['team_uuid'],
        'tr_id': tournaments[0]['tr_id'],
        'team_group': null,
        'match_played': 0,
        'won': 0,
        'draw': 0,
        'lost': 0,
        'goal_for': 0,
        'goal_against': 0,
        'goal_diff': 0,
        'group_position': 0,
        'position': 0,
        'team_id': counter.length + 1 | 0,
        'approved': 'pending'
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Stack(children: <Widget>[
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            width: 400,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                      'Choose your team, and the tournament you want to join',
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
                                      child: FormField(
                                        builder:
                                            (FormFieldState<String> state) {
                                          return TextField(
                                            decoration: InputDecoration(
                                              labelText: 'Choose team',
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon:
                                                  DropdownButtonFormField(
                                                value: selectedTeam,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedTeam = newValue;
                                                  });
                                                },
                                                items: dataTeams.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (dynamic value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value['team_name'],
                                                    child: Text(
                                                      value['team_name'],
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          );
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
                                        decoration: InputDecoration(
                                          labelText: 'Choose tournament',
                                          border: const OutlineInputBorder(),
                                          suffixIcon: DropdownButtonFormField(
                                            value: selectedTournament,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedTournament = newValue;
                                              });
                                            },
                                            items: dataTournaments
                                                .map<DropdownMenuItem<String>>(
                                                    (dynamic value) {
                                              return DropdownMenuItem<String>(
                                                value: value['tr_name'],
                                                child: Text(
                                                  value['tr_name'],
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  FadeAnimation(
                                    delay: 1,
                                    child: Roundedbutton(
                                      onPressed: () async {
                                        if (_auth.currentUser == null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                          ShowSnackBar.showSnackbar(
                                              context,
                                              'You need to be logged In before Joining a team',
                                              '',
                                              () {},
                                              Colors.red);
                                        } else if (selectedTeam == null ||
                                            selectedTournament == null) {
                                          ShowSnackBar.showSnackbar(
                                              context,
                                              'You must fill the data!',
                                              '',
                                              () {},
                                              Colors.red);
                                        } else {
                                          bool inserted = await insertData(
                                              selectedTournament!,
                                              selectedTeam!);
                                          if (inserted) {
                                            if (!mounted) {
                                              return;
                                            }
                                            Navigator.popAndPushNamed(context,
                                                RequestHistoryScreen.id);
                                            ShowSnackBar.showSnackbar(
                                                context,
                                                'Request sent successfully',
                                                '',
                                                () {},
                                                Colors.green[700]);
                                          } else {
                                            if (!mounted) {
                                              return;
                                            }
                                            ShowSnackBar.showSnackbar(
                                                context,
                                                'Request already sent or already joined',
                                                '',
                                                () {},
                                                Colors.orange[700]);
                                          }
                                        }
                                      },
                                      color: Colors.blue.shade600,
                                      title: 'Join',
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
                      Navigator.popAndPushNamed(context, RequestsScreen.id);
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
