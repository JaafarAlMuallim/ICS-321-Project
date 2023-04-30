import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';

class TeamInfoScreen extends StatefulWidget {
  const TeamInfoScreen({super.key, required this.teamUuid});
  final String teamUuid;
  static const id = 'teamInfo';

  @override
  State<TeamInfoScreen> createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen> {
  bool _loading = true;
  List<dynamic> teamsData = [];
  List<dynamic> captainsData = [];
  List<dynamic> coachesData = [];
  List<dynamic> playersData = [];
  List<dynamic> managerData = [];

  fetchData() async {
    teamsData = await supabase
        .from('team')
        .select('*, registered_team(*)')
        .eq('team_uuid', widget.teamUuid)
        .order('team_id', ascending: true);
    List teamUuids = [];
    for (dynamic team in teamsData) {
      teamUuids.add(team['team_uuid']);
    }
    // get team captains
    captainsData = await supabase
        .from('team_captain')
        .select('*, member(*)')
        .eq('team_uuid', widget.teamUuid);

    coachesData = await supabase
        .from('team_coach')
        .select('*, member (*)')
        .eq('team_uuid', widget.teamUuid);

    // get players in team
    playersData = await supabase
        .from('player')
        .select('*, member(*)')
        .eq('team_uuid', widget.teamUuid)
        .order('jersey_no', ascending: true);

    // get manager data
    managerData = await supabase
        .from('registered_team')
        .select('*, member:created_by(*)')
        .eq('team_uuid', widget.teamUuid);
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
                '${team['registered_team']['team_name']}',
                style: Style.h3,
              ),
            ),
            managerData.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: Text(
                      'Manager ${managerData[0]['member']['name']}',
                      style: Style.kSubtitleStyle,
                    ),
                  )
                : const SizedBox(),
            captains.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: Text(
                      'Captain ${captains[increment]['member']['name']}',
                      style: Style.kSubtitleStyle,
                    ),
                  )
                : const SizedBox(),
            coaches.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: Text(
                      'Coach ${coaches[increment]['member']['name']}',
                      style: Style.kSubtitleStyle,
                    ),
                  )
                : const SizedBox(),
            playersWidget.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: playersWidget[increment],
                    ),
                  )
                : const SizedBox(),
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
