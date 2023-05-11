import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:kfupm_soc/screens/Login_screen.dart';
import 'package:kfupm_soc/screens/request_history_screen.dart';
import 'package:kfupm_soc/widgets/rounded_button.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Core/fade_animation.dart';

final supabase = Supabase.instance.client;
final _auth = fire.FirebaseAuth.instance;

class CoachJoinTeamScreen extends StatefulWidget {
  const CoachJoinTeamScreen({super.key});
  static const String id = 'coach_joinTeam_screen';

  @override
  State<CoachJoinTeamScreen> createState() => _CoachJoinTeamScreenState();
}

class _CoachJoinTeamScreenState extends State<CoachJoinTeamScreen> {
  Color enabled = const Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color.fromARGB(255, 26, 37, 48);
  bool _loading = true;

  TextEditingController positionController = TextEditingController();
  TextEditingController jerseyNumberController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  List<dynamic> data = [];
  String? selectedTeam;
  String memberUuid = '';

  getUser() async {
    fire.User? user = _auth.currentUser;
    if (user != null) {
      List<dynamic> userInfo = await supabase
          .from('member')
          .select('*')
          .eq('phone_num', user.phoneNumber);
      setState(() {
        memberUuid = userInfo[0]['member_uuid'];
      });
    }
  }

  fetchData() async {
    List<dynamic> response =
        await supabase.from('team').select("*, registered_team(*)");
    setState(() {
      data = response;
      _loading = false;
    });
  }

  @override
  void initState() {
    getUser();
    fetchData();
    super.initState();
  }

  insertData(String teamName) async {
    List<dynamic> teams = await supabase
        .from('registered_team')
        .select()
        .eq('team_name', teamName);

    List<dynamic> exists = await supabase
        .from('team_coach')
        .select()
        .eq('team_uuid', teams[0]['team_uuid'])
        .eq('member_uuid', memberUuid);

    if (exists.isNotEmpty) {
      if (!mounted) {
        return;
      }
      ShowSnackBar.showSnackbar(
          context, 'Request In Process', '', () {}, Colors.orange);
      return;
    } else {
      await supabase.from('team_coach').upsert({
        'team_uuid': teams[0]['team_uuid'],
        'member_uuid': memberUuid,
        'approved': 'pending'
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                                      'Choose The Team You Want to Coach',
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
                                              hintText: 'Choose team',
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
                                                items: data.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (dynamic value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value:
                                                        value['registered_team']
                                                            ['team_name'],
                                                    child: Text(
                                                      value['registered_team']
                                                          ['team_name'],
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
                                  const SizedBox(height: 25),
                                  FadeAnimation(
                                    delay: 1,
                                    child: Roundedbutton(
                                      onPressed: () {
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
                                        } else if (selectedTeam == null) {
                                          ShowSnackBar.showSnackbar(
                                              context,
                                              'You must choose the team',
                                              '',
                                              () {},
                                              Colors.red);
                                        } else {
                                          insertData(selectedTeam!);
                                          Navigator.popAndPushNamed(
                                              context, RequestHistoryScreen.id);
                                          ShowSnackBar.showSnackbar(
                                              context,
                                              'Request sent successfully',
                                              '',
                                              () {},
                                              Colors.green[700]);
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
                      Navigator.pop(context);
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
