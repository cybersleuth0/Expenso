import 'package:expenso/Screens/expense/addExpense_Screen.dart';
import 'package:flutter/material.dart';

import 'homePage_Screen.dart';
import 'statisticScreen.dart';

class BasePage extends StatefulWidget {
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [HomePage(), StatisticPage(), AddNewExpense()];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewExpense()),
          );
        },
        backgroundColor: Colors.pinkAccent, // Change color as needed
        child: Icon(Icons.add, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // 🔥 Gives the curved effect
        notchMargin: 8.0, // Space between FAB and BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.pinkAccent : Colors.grey),
              onPressed: () => _onTabTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.bar_chart,
                  color: _selectedIndex == 1 ? Colors.pinkAccent : Colors.grey),
              onPressed: () => _onTabTapped(1),
            ),
            SizedBox(width: 40), // Space for FAB
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.grey),
              onPressed: () {}, // Implement this if needed
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.grey),
              onPressed: () {}, // Implement this if needed
            ),
          ],
        ),
      ),
    );
  }
}
