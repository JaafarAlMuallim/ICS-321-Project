import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_bubble.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';

final _auth = fire.FirebaseAuth.instance;

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});
  static const id = 'request_history';

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  bool _loading = true;
  List<dynamic> playersData = [];
  List<dynamic> usersData = [];
  List<dynamic> teamsData = [];
  List<dynamic> coachesData = [];
  List<dynamic> data = [];
  String playerUuid = '';
  fire.User? user = _auth.currentUser;
  fetchData() async {
    usersData = await supabase
        .from('member')
        .select('*')
        .eq('phone_num', user!.phoneNumber);

    setState(() {
      data = usersData;
      playerUuid = data[0]['member_uuid'];
    });

    playersData = await supabase
        .from('player')
        .select('*, member(*), registered_team(*, team(*))')
        .eq('member_uuid', playerUuid);
    List<dynamic> captinsData = await supabase
        .from('team_captain')
        .select('*')
        .eq('member_uuid', playerUuid);
    List<dynamic> managersData = await supabase
        .from('registered_team')
        .select('*')
        .eq('created_by', playerUuid);

    List teamUuids = [];
    for (dynamic player in playersData) {
      teamUuids.add(player['registered_team']['team_uuid']);
    }
    for (dynamic manager in managersData) {
      teamUuids.add(manager['team_uuid']);
    }
    for (dynamic captain in captinsData) {
      if (!teamUuids.contains(['team_uuid'])) {
        teamUuids.add(captain['team_uuid']);
      }
    }
    print(teamUuids);
    List<dynamic> resTeams = await supabase
        .from('team')
        .select('*, registered_team(*), tournament(*)')
        .in_('team_uuid', teamUuids);
    List<dynamic> resCoaches = await supabase
        .from('team_coach')
        .select('*, registered_team(*)')
        .eq('member_uuid', playerUuid);
    if (mounted) {
      setState(() {
        coachesData = resCoaches;
        teamsData = resTeams;
        usersData = playersData;
        _loading = false;
      });
    }
  }

  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    List<Widget> cards = [];
    for (dynamic request in playersData) {
      cards.add(CustomCard(
        containerContent: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox.fromSize(
                child: Image.asset('assets/images/welcomebkg.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                '${request['registered_team']['team_name']}',
                style: Style.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Player ${request['member']['name']} In Position ${request['position']} - ${request['jersey_no']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: CustomBubble(
                containerContent: Center(
                  child: Text(
                    'Status: ${request['approved'] == 'true' ? 'Approved' : request['approved'] == 'false' ? 'Rejected' : 'Pending'}',
                    style: Style.kSubtitleStyle,
                  ),
                ),
                onPress: () {},
                color: request['approved'] == 'true'
                    ? Colors.green.shade700
                    : request['approved'] == 'false'
                        ? Colors.red
                        : Colors.orange.shade700,
              ),
            ),
          ],
        ),
        onPress: () {},
        height: 460,
      ));
    }
    for (dynamic request in teamsData) {
      cards.add(CustomCard(
        containerContent: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox.fromSize(
                child: Image.asset('assets/images/welcomebkg.jpg'),
              ),
            ),
            teamsData.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      '${request['registered_team']['team_name']}',
                      style: Style.h3,
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Team member requested to join ${request['tournament']['tr_name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: CustomBubble(
                containerContent: Center(
                  child: Text(
                    'Status: ${request['approved'] == 'true' ? 'Approved' : request['approved'] == 'false' ? 'Rejected' : 'Pending'}',
                    style: Style.kSubtitleStyle,
                  ),
                ),
                onPress: () {},
                color: request['approved'] == 'true'
                    ? Colors.green.shade700
                    : request['approved'] == 'false'
                        ? Colors.red
                        : Colors.orange.shade700,
              ),
            ),
          ],
        ),
        onPress: () {},
        height: 460,
      ));
    }
    for (dynamic request in coachesData) {
      cards.add(CustomCard(
        containerContent: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox.fromSize(
                child: Image.asset('assets/images/welcomebkg.jpg'),
              ),
            ),
            coachesData.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      '${request['registered_team']['team_name']}',
                      style: Style.h3,
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Request to Coach ${request['registered_team']['team_name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: CustomBubble(
                containerContent: Center(
                  child: Text(
                    'Status: ${request['approved'] == 'true' ? 'Approved' : request['approved'] == 'false' ? 'Rejected' : 'Pending'}',
                    style: Style.kSubtitleStyle,
                  ),
                ),
                onPress: () {},
                color: request['approved'] == 'true'
                    ? Colors.green.shade700
                    : request['approved'] == 'false'
                        ? Colors.red
                        : Colors.orange.shade700,
              ),
            ),
          ],
        ),
        onPress: () {},
        height: 460,
      ));
    }

    return cards;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 5, top: 5),
          child: Text(
            'Requests History ',
            style: Style.kSubtitleStyle,
          ),
        ),
        elevation: 0,
        backgroundColor: CustomColors.navy,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://e1.pxfuel.com/desktop-wallpaper/189/764/desktop-wallpaper-latest-iphone-x-football-aesthetic.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        const Color(0x0fffffff).withOpacity(0.2),
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
                      stops: const [
                        0.1,
                        0.4,
                        0.7,
                        0.9,
                      ],
                    ),
                  ),
                  child: Center(
                    child: ListView(children: createCards()),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
