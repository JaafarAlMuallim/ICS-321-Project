// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:kfupm_soc/misc/custom_route.dart';
import 'package:kfupm_soc/screens/tournaments_screen.dart';
import 'package:kfupm_soc/widgets/icon_bottom_bar.dart';

import '../constants/styles.dart';

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
  int _currentIndex = BottomNavBar._selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Style.kAppBarColor,
      elevation: 0,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                icon: Icons.home,
                selected: BottomNavBar._selectedIndex == 0,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 0) {
                        Navigator.pushReplacement(
                          context,
                          CustomRoute(
                            child: TournamentScreen(),
                            direction: AxisDirection.right,
                          ),
                        );
                        BottomNavBar._selectedIndex = 0;
                      }
                    },
                  );
                },
              ),
              IconBottomBar(
                icon: Icons.calendar_month,
                selected: _currentIndex == 1,
                onPressed: () {
                  setState(() {
                    if (_currentIndex != 1) {
                      Navigator.pushReplacement(
                        context,
                        CustomRoute(
                          child: TournamentScreen(),
                          direction: _currentIndex <= 1
                              ? AxisDirection.left
                              : AxisDirection.right,
                        ),
                      );
                      BottomNavBar._selectedIndex = 1;
                    }
                  });
                },
              ),
              IconBottomBar(
                icon: Icons.map,
                selected: _currentIndex == 2,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 2) {
                        Navigator.pushReplacement(
                          context,
                          CustomRoute(
                            child: TournamentScreen(),
                            direction: _currentIndex <= 2
                                ? AxisDirection.left
                                : AxisDirection.right,
                          ),
                        );
                        BottomNavBar._selectedIndex = 2;
                      }
                    },
                  );
                },
              ),
              IconBottomBar(
                icon: Icons.account_circle,
                selected: _currentIndex == 3,
                onPressed: () {
                  setState(
                    () {
                      if (_currentIndex != 3) {
                        Navigator.pushReplacement(
                          context,
                          CustomRoute(
                            child: TournamentScreen(),
                            direction: AxisDirection.left,
                          ),
                        );
                        BottomNavBar._selectedIndex = 3;
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
