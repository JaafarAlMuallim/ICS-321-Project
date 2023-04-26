import 'package:flutter/material.dart';
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

    // TODO team name instead of id
    List<Widget> cards = [];
    print(mvps);
    for (dynamic doc in mvps) {
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
                        'MVP',
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
                      child: Text(
                        'Highest Number of MVPs was ${doc['x']} \nFrom The Player ${doc['pos']} - ${doc['jersey_no']} ${doc['name']} \nFrom Team ${doc['team_id']}',
                        style: Style.h3.copyWith(fontSize: 22),
                      ),
                    ),
                  )
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Text(
                        'GOALS',
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

                  //
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      child: Text(
                        'Highest Number of goals was ${doc['counter']} \nFrom The Player ${doc['pos']} - ${doc['jersey_no']} - ${doc['name']} \nFrom Team ${doc['team_id']}',
                        style: Style.h3.copyWith(fontSize: 22),
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
    print(mvps);
    goals = await supabase.rpc('count_goals');
    print(goals);
    redCards = await supabase.rpc('get_cards');
    print(redCards);

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
        backgroundColor: Style.kScaffoldColor,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ListView(
                children: createCards(),
              ),
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
