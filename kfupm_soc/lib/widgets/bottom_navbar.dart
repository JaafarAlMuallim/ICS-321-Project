import 'package:flutter/material.dart';
import 'package:kfupm_soc/constants/app_theme.dart';
import 'package:kfupm_soc/constants/styles.dart';
import 'package:kfupm_soc/screens/profile_screen.dart';
import 'package:kfupm_soc/screens/requests_screen.dart';
import 'package:kfupm_soc/screens/stats_screen.dart';
import 'package:kfupm_soc/screens/teams_screen.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static int _selectedIndex = 0;
  static reset() {
    _selectedIndex = 0;
  }

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final int _currentIndex = BottomNavBar._selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: CustomColors.navy,
      elevation: 0,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                icon: Icons.tour,
                selected: BottomNavBar._selectedIndex == 0,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 0) {
                        Navigator.pushReplacementNamed(
                            context, TournamentScreen.id);
                        BottomNavBar._selectedIndex = 0;
                      }
                    },
                  );
                },
              ),
              IconBottomBar(
                icon: Icons.group_rounded,
                selected: BottomNavBar._selectedIndex == 1,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 1) {
                        Navigator.pushReplacementNamed(context, TeamScreen.id);
                        BottomNavBar._selectedIndex = 1;
                      }
                    },
                  );
                },
              ),
              IconBottomBar(
                  icon: Icons.bar_chart,
                  selected: _currentIndex == 2,
                  onPressed: () {
                    setState(() {
                      if (_currentIndex != 2) {
                        Navigator.pushReplacementNamed(
                            context, StatsticsScreen.id);
                        BottomNavBar._selectedIndex = 2;
                      }
                    });
                  }),
              IconBottomBar(
                icon: Icons.request_page,
                selected: _currentIndex == 3,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 3) {
                        Navigator.pushReplacementNamed(
                            context, RequestsScreen.id);
                        BottomNavBar._selectedIndex = 3;
                      }
                    },
                  );
                },
              ),
              IconBottomBar(
                icon: Icons.account_circle,
                selected: _currentIndex == 4,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 4) {
                        Navigator.pushReplacementNamed(
                            context, ProfileScreen.id);
                        BottomNavBar._selectedIndex = 4;
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {super.key,
      required this.icon,
      required this.selected,
      required this.onPressed});
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon,
              size: 40,
              color: selected ? Style.kActivated : Style.kInActivated),
        ),
      ],
    );
  }
}
