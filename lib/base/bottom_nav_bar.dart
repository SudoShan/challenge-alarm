import 'package:challenge_alarm/app_screens/reminder_screen.dart';
import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';
import '../app_screens/alarm_screen.dart';
import '../app_screens/profile_screen.dart';
import '../utils/user_manager.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final appScreens = [const AlarmScreen(), const ReminderScreen(), const ProfileScreen()];
  final appBarTitles = ["Alarm", "Reminders", "Profile"];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserManager.isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: appScreens[_selectedIndex],
      appBar: AppBar(
        title: Text(
          appBarTitles[_selectedIndex],
          style: MyStyles.head1,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: MyStyles.myPurple,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: "Alarm"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: "Reminders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}
