import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/team_info_screen.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';

class StatsticsScreen extends StatefulWidget {
  const StatsticsScreen({super.key});
  static String id = 'stats';

  @override
  State<StatsticsScreen> createState() => _StatsticsScreenState();
}

class _StatsticsScreenState extends State<StatsticsScreen> {
  List<dynamic> data = [];
  bool _loading = true;
  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    List<Widget> cards = [];
    for (dynamic doc in data) {
      cards.add(
        CustomCard(
          containerContent:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox.fromSize(
                child: Image.asset('assets/images/welcomebkg.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Team ${doc['team_id']}',
                style: Style.h3,
              ),
            ),
            // TODO Table view
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text(
                      'Group ${doc['team_group']}',
                      style: Style.kSubtitleStyle,
                    ),
                    Text(
                      'Played - W - D - L \n  ${doc['match_played']} - ${doc['won']} - ${doc['draw']} - ${doc['lost']} ||| - Points ${doc['points']}',
                      style: Style.kSubtitleStyle,
                    ),
                    Text(
                      'Goals +/- \n \t\t${doc['goal_for']}/${doc['goal_against']}',
                      style: Style.kSubtitleStyle,
                    ),
                  ],
                )),
          ]),
          onPress: () {
            Navigator.pushNamed(context, TeamInfoScreen.id,
                arguments: doc['team_uuid']);
          },
          height: 430,
        ),
      );
    }
    setState(() {
      _loading = false;
    });
    return cards;
  }

  fetchData() async {
    data = await supabase.from('team').select();
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
