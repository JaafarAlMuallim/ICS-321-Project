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
    // TODO team name instead of id
    List<Widget> cards = [];
    for (dynamic doc in data) {
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
            FadeAnimation(
              delay: 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Text(
                  'Team ${doc['team_id']}',
                  style: Style.h3,
                ),
              ),
            ),
            // TODO Table view
            FadeAnimation(
              delay: 0.8,
              child: Padding(
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
            ),
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
