import 'package:flutter/material.dart';

class TournamentInfoScreen extends StatefulWidget {
  const TournamentInfoScreen({super.key, required this.tournamentId});
  final String tournamentId;
  static const id = 'tournamentInfo';

  @override
  State<TournamentInfoScreen> createState() => _TournamentInfoScreenState();
}

class _TournamentInfoScreenState extends State<TournamentInfoScreen> {
  fetchData() async {
    throw UnimplementedError();
  }

  @override
  void initState() {
    // fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
