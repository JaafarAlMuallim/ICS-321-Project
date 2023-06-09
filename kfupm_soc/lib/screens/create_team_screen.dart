import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:kfupm_soc/screens/Login_screen.dart';
import 'package:kfupm_soc/screens/profile_screen.dart';
import 'package:kfupm_soc/widgets/rounded_button.dart';
import 'package:kfupm_soc/widgets/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Core/fade_animation.dart';

final supabase = Supabase.instance.client;
final _auth = fire.FirebaseAuth.instance;

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});
  static const String id = 'create_team_screen';

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  Color enabled = const Color.fromARGB(255, 56, 76, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color.fromARGB(255, 26, 37, 48);
  bool _loading = true;

  TextEditingController positionController = TextEditingController();
  TextEditingController jerseyNumberController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  List<dynamic> data = [];
  List<String> pos = ['GK', 'DF', 'MF', 'FD'];
  String? selectedTeam;
  String? selectedPosition;
  String playerUuid = '';

  getUser() async {
    fire.User? user = _auth.currentUser;
    if (user != null) {
      data = await supabase
          .from('member')
          .select('*')
          .eq('phone_num', user.phoneNumber);
      setState(() {
        playerUuid = data[0]['member_uuid'];
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
    await supabase.from("registered_team").insert(
        {'created_by': playerUuid, 'team_name': teamName, 'approved': "true"});
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
                                      'Enter the team name',
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
                                        controller: teamController,
                                        decoration: const InputDecoration(
                                          hintText: 'Team Name',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.account_box_outlined,
                                            size: 20,
                                          ),
                                          enabledBorder: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ),
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
                                        } else if (teamController.text == "") {
                                          ShowSnackBar.showSnackbar(
                                              context,
                                              'You must enter team name',
                                              '',
                                              () {},
                                              Colors.red);
                                        } else {
                                          insertData(teamController.text);
                                          Navigator.popAndPushNamed(
                                              context, ProfileScreen.id);
                                          ShowSnackBar.showSnackbar(
                                              context,
                                              'Request sent successfully',
                                              '',
                                              () {},
                                              Colors.green[700]);
                                        }
                                      },
                                      color: Colors.blue.shade600,
                                      title: 'Create',
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
                        return const ProfileScreen();
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
