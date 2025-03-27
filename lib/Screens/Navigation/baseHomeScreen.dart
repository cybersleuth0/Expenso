import 'package:flutter/material.dart';
import 'homePage_Screen.dart';
import 'statisticScreen.dart';

class BasePage extends StatefulWidget {
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [HomePage(), StatisticPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.bar_chart), label: "Statistic"),
              NavigationDestination(icon: Icon(Icons.add), label: "Profile"),
              NavigationDestination(
                  icon: Icon(Icons.notifications_none_rounded),
                  label: "Profile"),
              NavigationDestination(
                  icon: Icon(Icons.lightbulb_outline), label: "Profile"),
            ]));
  }
}
