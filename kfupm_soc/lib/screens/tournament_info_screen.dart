import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/match_info_screen.dart';
import 'package:kfupm_soc/screens/participated_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_bubble.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class TournamentInfoScreen extends StatefulWidget {
  const TournamentInfoScreen({super.key, required this.tournamentId});
  final String tournamentId;
  static const id = 'tournamentInfo';

  @override
  State<TournamentInfoScreen> createState() => _TournamentInfoScreenState();
}

class _TournamentInfoScreenState extends State<TournamentInfoScreen> {
  bool _loading = true;
  List<dynamic> teamsData = [];
  List<dynamic> venueData = [];
  List<dynamic> matchesData = [];
  fetchData() async {
    teamsData = await supabase
        .from('team')
        .select(
          '*, registered_team(*)',
        )
        .eq('tr_id', widget.tournamentId);
    List teamUuids = [];

    for (dynamic team in teamsData) {
      teamUuids.add(team['team_uuid']);
    }
    matchesData = await supabase
        .from('match_details')
        .select(
            '*, match_played:match_uuid(*, referee (*), member:player_of_match(*)), asst_referee (*)')
        .eq('tr_id', widget.tournamentId)
        .order('play_date', ascending: true);
    // get match uuid in a list
    List matchUuids = [];
    for (dynamic match in matchesData) {
      matchUuids.add(match['match_uuid']);
    }
    venueData =
        await supabase.from('venue').select('*, match_played (venue_id)');
    setState(() {
      _loading = false;
    });
  }

  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    List matches = [];
    for (dynamic doc in matchesData) {
      List teams = [];
      for (dynamic doc1 in teamsData) {
        if (doc1['team_uuid'] == doc['team_one'] ||
            doc1['team_uuid'] == doc['team_two']) {
          teams.add(doc1);
        }
      }
      matches.add(teams);
    }
    // get venues for each match
    List venues = [];
    for (dynamic doc in matchesData) {
      for (dynamic doc1 in venueData) {
        if (doc1['venue_id'] == doc['match_played']['venue_id']) {
          venues.add(doc1);
        }
      }
    }
    List<Widget> cards = [];
    int increment = 0;
    for (dynamic match in matchesData) {
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
                match['play_date'],
                style: Style.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                '${matches[increment][0]['registered_team']['team_name']} VS ${matches[increment][1]['registered_team']['team_name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Ended: ${match['match_played']['goal_score']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'MVP: ${match['match_played']['member'] != null ? match['match_played']['member']['name'] : 'N/A'}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Referee: ${match['match_played']['referee']['referee_name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Assistant: ${match['asst_referee']['asst_ref_name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Venue: ${venues[increment]['venue_name']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Audience: ${match['match_played']['audience'] ?? 0} / ${venues[increment]['aud_capacity']} ',
                style: Style.kSubtitleStyle,
              ),
            ),
          ],
        ),
        onPress: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MatchInfoScreen(matchUuid: match['match_uuid'])));
        },
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
            'Matches',
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
                    child: ListView(
                      children: [
                        CustomBubble(
                            containerContent: const Center(
                                child: Text(
                              'Show Participated Teams',
                              style: Style.kTextStyle,
                            )),
                            color: Colors.blue.shade400,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ParticipatedScreen(
                                          tournamentId: widget.tournamentId)));
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        ...createCards()
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
