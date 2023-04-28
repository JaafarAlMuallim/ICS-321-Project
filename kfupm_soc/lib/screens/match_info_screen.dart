import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MatchInfoScreen extends StatefulWidget {
  const MatchInfoScreen({super.key, required this.matchUuid});
  static String id = 'matchInfo';
  final String matchUuid;

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
  bool _loading = true;
  List<dynamic> matchTeams = [];
  List<dynamic> teams = [];
  List<dynamic> coaches = [];
  List<dynamic> captains = [];
  List<dynamic> subs = [];
  List<dynamic> goals = [];
  List<dynamic> cards = [];
  List<dynamic> penaltyShootout = [];
  List<dynamic> goalsArr = [];
  List<dynamic> cardsArr = [];
  List<dynamic> subsArray = [];
  List<dynamic> penaltiesArr = [];

  fetchData() async {
    matchTeams = await supabase
        .from('match_details')
        .select('*')
        .eq('match_uuid', widget.matchUuid);
    List teamUuids = [];
    for (dynamic value in matchTeams) {
      teamUuids.add(value['team_one']);
      teamUuids.add(value['team_two']);
    }
    teams = await supabase
        .from('team')
        .select('*, registered_team(*)')
        .in_('team_uuid', teamUuids)
        .order('team_id', ascending: true);
    coaches = await supabase
        .from('team_coach')
        .select('*, member(*)')
        .in_('team_uuid', teamUuids);

    captains = await supabase
        .from('team_captain')
        .select('*, member(*, player(*, registered_team(*, team(*))))')
        .in_('team_uuid', teamUuids);

    subs = await supabase
        .from('player_in_out')
        .select('*, member(*, player(*, registered_team(*, team(*))))')
        .eq('match_no', widget.matchUuid);

    goals = await supabase
        .from('goal_details')
        .select('*, member(*, player(*, registered_team(*, team(*))))')
        .eq('match_no', widget.matchUuid)
        .order('goal_time', ascending: true);

    cards = await supabase
        .from('player_booked')
        .select('*, member(*, player(*, registered_team(*, team(*))))')
        .eq('match_no', widget.matchUuid)
        .order('booking_time', ascending: true);

    for (dynamic goal in goals) {
      if (goal['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[0]['team_uuid'] &&
          goal['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[0]['tr_id']) {
        goalsArr.add(goal);
      } else if (goal['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[1]['team_uuid'] &&
          goal['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[1]['tr_id']) {
        goalsArr.add(goal);
      }
    }

    for (dynamic goal in goals) {
      if (goal['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[0]['team_uuid'] &&
          goal['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[0]['tr_id']) {
        goalsArr.add(goal);
      } else if (goal['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[1]['team_uuid'] &&
          goal['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[1]['tr_id']) {
        goalsArr.add(goal);
      }
    }
    for (dynamic card in cards) {
      if (card['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[0]['team_uuid'] &&
          card['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[0]['tr_id']) {
        cardsArr.add(card);
      } else if (card['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[1]['team_uuid'] &&
          card['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[1]['tr_id']) {
        cardsArr.add(card);
      }
    }
    for (dynamic penalty in penaltyShootout) {
      if (penalty['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[0]['team_uuid'] &&
          penalty['member']['player'][0]['registered_team']['team'][0]
                  ['tr_id'] ==
              teams[0]['tr_id']) {
        penaltiesArr.add(penalty);
      } else if (penalty['member']['player'][0]['registered_team']
                  ['team_uuid'] ==
              teams[1]['team_uuid'] &&
          penalty['member']['player'][0]['registered_team']['team'][0]
                  ['tr_id'] ==
              teams[1]['tr_id']) {
        penaltiesArr.add(penalty);
      }
    }
    for (dynamic sub in subs) {
      if (sub['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[0]['team_uuid'] &&
          sub['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[0]['tr_id']) {
        subsArray.add(sub);
      } else if (sub['member']['player'][0]['registered_team']['team_uuid'] ==
              teams[1]['team_uuid'] &&
          sub['member']['player'][0]['registered_team']['team'][0]['tr_id'] ==
              teams[1]['tr_id']) {
        subsArray.add(sub);
      }
    }

    setState(() {
      _loading = false;
    });
  }

  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    // get venues for each match
    List<Widget> cards = [];
    dynamic match = matchTeams[0];
    List<Widget> scoreresTeam1 = [];
    List<Widget> scoreresTeam2 = [];
    List<Widget> goalTimes = [];
    List<Widget> cardsTeam1 = [];
    List<Widget> cardsTeam2 = [];
    List<Widget> cardTimes = [];

    for (int i = 0; i < goalsArr.length / 2; i++) {
      dynamic goal = goalsArr[i];
      if (goal['member']['player'][0]['registered_team']['team_uuid'] ==
          teams[0]['team_uuid']) {
        goalTimes.add(
          RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.sports_soccer_sharp,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text: " ${goal['goal_time']}'",
                    style: Style.h3.copyWith(fontSize: 22))
              ],
            ),
          ),
        );
        scoreresTeam1.add(
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: " ${goal['member']['name']}",
                  style: Style.h3.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        );
        scoreresTeam2.add(
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: " - ",
                  style: Style.h3.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        );
      } else if (goal['member']['player'][0]['registered_team']['team_uuid'] ==
          teams[1]['team_uuid']) {
        goalTimes.add(
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "${goal['goal_time']}' ",
                    style: Style.h3.copyWith(fontSize: 22)),
                const WidgetSpan(
                  child: Icon(
                    Icons.sports_soccer_sharp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
        scoreresTeam2.add(
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: " ${goal['member']['name']}",
                  style: Style.h3.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        );
        scoreresTeam1.add(
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: " - ",
                  style: Style.h3.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        );
      }
    }
    for (int j = 0; j < cardsArr.length; j++) {
      dynamic card = cardsArr[j];

      bool sentOff = card['sent_out'] == 'N';
      if (card['member']['player'][0]['registered_team']['team_uuid'] ==
          teams[0]['team_uuid']) {
        cardTimes.add(
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.sd_card_alert,
                    color: sentOff ? Colors.yellow : Colors.red,
                  ),
                ),
                TextSpan(
                  text: " ${card['booking_time']}'",
                  style: Style.h3.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        );
        cardsTeam1.add(
          Text(
            '${card['member']['name']}',
            style: Style.h3.copyWith(fontSize: 22),
          ),
        );
        cardsTeam2.add(
          Text(
            '-',
            style: Style.h3.copyWith(fontSize: 22),
          ),
        );
      } else if (card['member']['player'][0]['registered_team']['team_uuid'] ==
          teams[1]['team_uuid']) {
        cardTimes.add(
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: " ${card['booking_time']}' ",
                  style: Style.h3.copyWith(fontSize: 22),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.sd_card_alert,
                    color: sentOff ? Colors.yellow : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
        cardsTeam2.add(
          Text(
            '${card['member']['name']}',
            style: Style.h3.copyWith(fontSize: 22),
          ),
        );
        cardsTeam1.add(
          Text(
            '-',
            style: Style.h3.copyWith(fontSize: 22),
          ),
        );
      }

      List<Widget> coachTeam1 = [];
      List<Widget> coachTeam2 = [];
      List<Widget> captainTeam1 = [];
      List<Widget> captainTeam2 = [];
      for (int i = 0; i < coaches.length; i++) {
        if (coaches[i]['team_uuid'] == teams[0]['team_uuid']) {
          coachTeam1.add(
            Text(
              '${coaches[i]['member']['name']}',
              style: Style.h3.copyWith(fontSize: 22),
            ),
          );
        } else if (coaches[i]['team_uuid'] == teams[1]['team_uuid']) {
          coachTeam2.add(
            Text(
              '${coaches[i]['member']['name']}',
              style: Style.h3.copyWith(fontSize: 22),
            ),
          );
        }
      }
      for (int i = 0; i < captains.length; i++) {
        if (captains[i]['team_uuid'] == teams[0]['team_uuid']) {
          captainTeam1.add(
            Text(
              '${captains[i]['member']['name']}',
              style: Style.h3.copyWith(fontSize: 22),
            ),
          );
        } else if (captains[i]['team_uuid'] == teams[1]['team_uuid']) {
          captainTeam2.add(
            Text(
              '${captains[i]['member']['name']}',
              style: Style.h3.copyWith(fontSize: 22),
            ),
          );
        }
      }
      if (coachTeam1.isEmpty) {
        coachTeam1.add(Text(
          'No Coach',
          style: Style.h3.copyWith(fontSize: 22),
        ));
      } else if (coachTeam2.isEmpty) {
        coachTeam2.add(Text(
          'No Coach',
          style: Style.h3.copyWith(fontSize: 22),
        ));
      }
      if (captainTeam1.isEmpty) {
        captainTeam1.add(
          Text(
            'No Captain',
            style: Style.h3.copyWith(fontSize: 22),
          ),
        );
      } else if (captainTeam2.isEmpty) {
        captainTeam2.add(
          Text(
            'No Captain',
            style: Style.h3.copyWith(fontSize: 22),
          ),
        );
      }

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${teams[0]['registered_team']['team_name']}',
                    style: Style.kSubtitleStyle,
                    textAlign: TextAlign.justify,
                  ),
                  const Text(
                    'VS',
                    style: Style.kSubtitleStyle,
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '${teams[1]['registered_team']['team_name']}',
                    style: Style.kSubtitleStyle,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: goalsArr.isEmpty
                    ? const Center(child: Text('No Goals in this match'))
                    : Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: scoreresTeam1,
                          )),
                          Expanded(
                              child: Column(
                            children: goalTimes,
                          )),
                          Expanded(
                              child: Column(
                            children: scoreresTeam2,
                          )),
                        ],
                      )),
            const Divider(
              height: 12,
              thickness: 2,
              color: Colors.black,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: cardsArr.isEmpty
                    ? const Center(
                        child: Text('No Yellow / Red Cards in this match'))
                    : Row(
                        children: [
                          Expanded(
                            child: Column(children: cardsTeam1),
                          ),
                          Expanded(
                            child: Column(children: cardTimes),
                          ),
                          Expanded(
                            child: Column(children: cardsTeam2),
                          ),
                        ],
                      )),
            const Divider(
              height: 12,
              thickness: 2,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: coaches.isEmpty
                  ? const Center(child: Text('No Coaches in both teams'))
                  : Row(
                      children: [
                        Expanded(
                          child: Column(children: coachTeam1),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Coaches',
                                style: Style.h3.copyWith(fontSize: 22),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(children: coachTeam2),
                        ),
                      ],
                    ),
            ),
            const Divider(
              height: 12,
              thickness: 2,
              color: Colors.black,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: captains.isEmpty
                    ? const Center(child: Text('No Coaches in both teams'))
                    : Row(
                        children: [
                          Expanded(
                            child: Column(children: captainTeam1),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Captains',
                                  style: Style.h3.copyWith(fontSize: 22),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(children: captainTeam2),
                          ),
                        ],
                      )
                // : Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         captains[0]['team_uuid'] == teams[0]['team_uuid']
                //             ? '${captains[0]['member']['name']}'
                //             : captains[1]['team_uuid'] ==
                //                     teams[0]['team_uuid']
                //                 ? '${captains[1]['member']['name']}'
                //                 : 'No Captain',
                //         style: Style.kSubtitleStyle,
                //       ),
                //       const Text(
                //         'Captains',
                //         style: Style.kSubtitleStyle,
                //       ),
                //       Text(
                //         captains[0]['team_uuid'] == teams[1]['team_uuid']
                //             ? '${captains[0]['member']['name']}'
                //             : captains[0]['team_uuid'] ==
                //                     teams[1]['team_uuid']
                //                 ? '${captains[0]['member']['name']}'
                //                 : 'No Captain',
                //         style: Style.kSubtitleStyle,
                //       ),
                //     ],
                //   ),
                ),
          ],
        ),
        onPress: () {},
        height: 710,
      ));
      setState(() {
        _loading = false;
      });
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
          : Center(
              child: ListView(
                children: createCards(),
              ),
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
