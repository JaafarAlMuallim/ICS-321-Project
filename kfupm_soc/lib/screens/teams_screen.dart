import 'package:flutter/material.dart';
import 'package:kfupm_soc/Core/fade_animation.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/team_info_screen.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});
  static String id = 'teams';

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<dynamic> data = [];
  bool _loading = true;
  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    List<Widget> cards = [];

    for (dynamic doc in data) {
      Widget groupCol;
      Widget playedCol;
      Widget wonCol;
      Widget drawCol;
      Widget lostCol;
      Widget pointsCol;
      Widget goalsCol;
      groupCol = Column(children: [
        Text('Group', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['team_group'] ?? 'XX'}',
            style: Style.h3.copyWith(fontSize: 14))
      ]);
      playedCol = Column(children: [
        Text('Played', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['match_played']}', style: Style.h3.copyWith(fontSize: 14))
      ]);
      wonCol = Column(children: [
        Text('Won', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['won']}')
      ]);
      drawCol = Column(children: [
        Text('Draw', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['draw']}', style: Style.h3.copyWith(fontSize: 14))
      ]);
      lostCol = Column(children: [
        Text('Lost', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['lost']}', style: Style.h3.copyWith(fontSize: 14))
      ]);
      pointsCol = Column(children: [
        Text('Points', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['points']}', style: Style.h3.copyWith(fontSize: 14))
      ]);
      goalsCol = Column(children: [
        Text('Goals +/-', style: Style.h3.copyWith(fontSize: 14)),
        Text('${doc['goal_for']}/${doc['goal_against']}',
            style: Style.h3.copyWith(fontSize: 14))
      ]);
      cards.add(
        CustomCard(
          containerContent:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            FadeAnimation(
              delay: 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox.fromSize(
                  child: Image.asset('assets/images/welcomebkg.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FadeAnimation(
              delay: 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Text(
                  '${doc['registered_team']['team_name']}',
                  style: Style.h3,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FadeAnimation(
              delay: 0.8,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      groupCol,
                      const VerticalDivider(
                        color: Colors.orange,
                      ),
                      playedCol,
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      wonCol,
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      drawCol,
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      lostCol,
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      goalsCol,
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      pointsCol,
                    ],
                  )),
            ),
          ]),
          onPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TeamInfoScreen(teamUuid: doc['team_uuid'])));
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
    data = await supabase.from('team').select('*, registered_team(*)');
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
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 5, top: 5),
            child: Text(
              'Teams',
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
                      delay: 0.4,
                      child: Center(
                        child: ListView(
                          children: createCards(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
