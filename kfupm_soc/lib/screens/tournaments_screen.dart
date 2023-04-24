import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/tournament_info_screen.dart';
import 'package:kfupm_soc/widgets/bottom_navbar.dart';
import 'package:kfupm_soc/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});
  static const id = 'tournament';

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  List<dynamic> data = [];
  bool _loading = true;
  List<Widget> createCards() {
    setState(() {
      _loading = true;
    });
    List<Widget> cards = [];
    for (dynamic doc in data) {
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                doc['tr_name'],
                style: Style.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                '${doc['start_date']} - ${doc['end_date']}',
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
                      TournamentInfoScreen(tournamentId: doc['tr_id'])));
        },
        height: 430,
      ));
      setState(() {
        _loading = false;
      });
    }
    return cards;
  }

  fetchData() async {
    data = await supabase.from('tournament').select();
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
            'Tournament',
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
// Sign Out
// Container(
//                 // text button for sign out
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xFF2697FF),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 14.0,
//                       horizontal: 80,
//                     ),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     ),
//                   ),
//                   onPressed: () {
//                     try {
//                       _auth.signOut();
//                       Navigator.popAndPushNamed(context, LoginScreen.id);
//                       ShowSnackBar.showSnackbar(
//                           context, 'Sign Out Succesfully', '', () {
//                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                       }, Colors.green);
//                     } on FirebaseException catch (e) {
//                       ShowSnackBar.showSnackbar(context, e.message, "Sign Out",
//                           () {
//                         Navigator.popAndPushNamed(context, LoginScreen.id);
//                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                       }, Style.containerColor);
//                     }
//                   },
//                   child: const Text(
//                     'Sign Out',
//                     style: Style.kTextStyle,
//                   ),
//                 ),
//               ),