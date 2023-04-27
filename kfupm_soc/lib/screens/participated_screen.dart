import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';

class ParticipatedScreen extends StatefulWidget {
  const ParticipatedScreen({super.key, required this.tournamentId});
  final String tournamentId;
  static const id = 'participation';

  @override
  State<ParticipatedScreen> createState() => _ParticipatedScreenState();
}

class _ParticipatedScreenState extends State<ParticipatedScreen> {
  bool _loading = true;
  List<dynamic> teamsData = [];
  List<dynamic> captainsData = [];
  List<dynamic> coachesData = [];
  List<dynamic> playersData = [];

  fetchData() async {
    teamsData = await supabase
        .from('team')
        .select()
        .eq('tr_id', widget.tournamentId)
        .order('team_id', ascending: true);
    List teamUuids = [];
    for (dynamic team in teamsData) {
      teamUuids.add(team['team_uuid']);
    }
    // get team captains
    captainsData = await supabase
        .from('team_captain')
        .select('*, member(*)')
        .in_('team_uuid', teamUuids);

    coachesData = await supabase
        .from('team_coach')
        .select('*, member (*)')
        .in_('team_uuid', teamUuids);

    // get players in team
    playersData = await supabase
        .from('player')
        .select('*, member(*)')
        .in_('team_uuid', teamUuids)
        .order('jersey_no', ascending: true);
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });

    // get team captains and coaches in a list
    List captains = [];
    List coaches = [];
    for (dynamic team in teamsData) {
      for (dynamic captain in captainsData) {
        for (dynamic player in playersData) {
          if (team['team_uuid'] == captain['team_uuid'] &&
              captain['team_uuid'] == player['team_uuid']) {
            captains.add(player);
          }
        }
      }
      for (dynamic coach in coachesData) {
        if (team['team_uuid'] == coach['team_uuid']) {
          coaches.add(coach);
        }
      }
    }
    // get players of each team in a list
    List<List> players = [];
    for (dynamic team in teamsData) {
      List currentTeam = [];
      for (dynamic player in playersData) {
        if (team['team_uuid'] == player['team_uuid']) {
          currentTeam.add(player);
        }
      }
      players.add(currentTeam);
    }
    List<List<Widget>> playersWidget = [];
    for (int i = 0; i < players.length; i++) {
      List<Widget> teams = [];
      for (int j = 0; j < players[i].length; j++) {
        teams.add(Text(
            '${players[i][j]['position']} - ${players[i][j]['jersey_no']} - ${players[i][j]['member']['name']}'));
      }
      playersWidget.add(teams);
    }
    List<Widget> cards = [];
    int increment = 0;
    for (dynamic team in teamsData) {
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
                'Team ${team['team_id']}',
                style: Style.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Captain ${captains[increment]['member']['name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Coach ${coaches[increment]['member']['name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: playersWidget[increment],
              ),
            ),
          ],
        ),
        onPress: () {},
        height: 580,
      ));
      increment++;
    }
    setState(() {
      _loading = false;
    });
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
            'Teams ',
            style: Style.kSubtitleStyle,
          ),
        ),
        elevation: 0,
        backgroundColor: CustomColors.navy,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ListView(children: createCards()),
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
