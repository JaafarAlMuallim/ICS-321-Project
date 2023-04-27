import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
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
  List<dynamic> data = [];
  String playerUuid = '';
  getUser() async {
    fire.User? user = _auth.currentUser;
    if (user != null) {
      data = await supabase
          .from('member')
          .select('*')
          .eq('phone_num', user.phoneNumber);
      setState(() {
        playerUuid = data[0]['member_uuid'];
      });
    }
    setState(() {
      _loading = false;
    });
  }

  fetchData() async {
    // get all players from players table where approved = 'true'
    playersData = await supabase
        .from('player')
        .select('*, member(*), registered_team(*)')
        .eq('member_uuid', playerUuid);

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
    List<Widget> cards = [];
    int increment = 0;
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
                'Team ${request['registered_team']['team_name']}',
                style: Style.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Player ${request['member']['name']} In Position ${request['pos']} - ${request['jersey_no']}',
                style: Style.kSubtitleStyle,
              ),
            ),
            // TODO make it as bubble and change color according to pending - orange, declined - red, approved - green
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'Status: ${request['approved']}',
                style: Style.kSubtitleStyle,
              ),
            ),
          ],
        ),
        onPress: () {},
        height: 330,
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
    getUser();
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
          : Center(
              child: ListView(children: createCards()),
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
