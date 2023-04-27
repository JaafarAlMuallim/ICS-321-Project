import 'package:flutter/material.dart';
import 'package:kfupm_soc/Core/fade_animation.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';

class StatsticsScreen extends StatefulWidget {
  const StatsticsScreen({super.key});
  static String id = 'stats';

  @override
  State<StatsticsScreen> createState() => _StatsticsScreenState();
}

class _StatsticsScreenState extends State<StatsticsScreen> {
  List<dynamic> mvps = [];
  List<dynamic> goals = [];
  List<dynamic> redCards = [];
  bool _loading = true;
  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    List<Widget> cards = [];
    for (dynamic doc in mvps) {
      cards.add(
        CustomCard(
            containerContent: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeAnimation(
                    delay: 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: Text(
                          'MVP',
                          style: Style.h3.copyWith(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox.fromSize(
                        child: Image.asset(
                          'assets/images/welcomebkg.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    delay: 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: Text(
                          'Highest Number of MVPs was ${doc['coutner']} \nFrom The Player ${doc['pos']} - ${doc['jersey_no']} ${doc['name']} \nFrom Team ${doc['team_id']}',
                          style: Style.h3.copyWith(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ]),
            onPress: () {},
            height: 430),
      );
    }
    for (dynamic doc in goals) {
      cards.add(
        CustomCard(
            containerContent: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeAnimation(
                    delay: 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: Text(
                          'GOALS',
                          style: Style.h3.copyWith(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox.fromSize(
                        child: Image.asset(
                          'assets/images/welcomebkg.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    delay: 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: Text(
                          'Highest Number of goals was ${doc['counter']} \nFrom The Player ${doc['pos']} - ${doc['jersey_no']} - ${doc['name']} \nFrom Team ${doc['team_id']}',
                          style: Style.h3.copyWith(fontSize: 22),
                        ),
                      ),
                    ),
                  )
                ]),
            onPress: () {},
            height: 430),
      );
    }
    for (dynamic card in redCards) {
      cards.add(
        CustomCard(
            containerContent: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Text(
                        'RED CARDS',
                        style: Style.h3.copyWith(fontSize: 22),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox.fromSize(
                      child: Image.asset(
                        'assets/images/welcomebkg.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${card['pos']} - ${card['jersey_no']} - ${card['name']} of team ${card['team_id']} got ',
                              style: Style.h3.copyWith(fontSize: 22),
                            ),
                            const WidgetSpan(
                              child: Icon(
                                Icons.sd_card_alert_sharp,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: '\nIn Match ${card['match_id']}',
                              style: Style.h3.copyWith(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
            onPress: () {},
            height: 430),
      );
    }
    setState(() {
      _loading = false;
    });
    return cards;
  }

  fetchData() async {
    mvps = await supabase.rpc('count_mvps');
    goals = await supabase.rpc('count_goals');
    redCards = await supabase.rpc('get_cards');

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
            'Statistics',
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
