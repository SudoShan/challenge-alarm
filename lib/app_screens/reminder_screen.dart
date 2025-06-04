import 'package:challenge_alarm/app_screens/add_reminder_screen.dart';
import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'edit_reminder_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final ScrollController scrollController = ScrollController();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isFabVisible) {
          setState(() {
            isFabVisible = true;
          });
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (isFabVisible) {
          setState(() {
            isFabVisible = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> reminders = [
    {
      'name': 'Doctor Appointment',
      'time': '10:00 AM',
      'date': '2025-03-16',
      'days': ['Monday', 'Wednesday', 'Friday'],
      'isOn': true,
    },
    {
      'name': 'Gym Session',
      'time': '06:00 AM',
      'date': '2025-03-17',
      'days': ['Tuesday', 'Thursday', 'Saturday'],
      'isOn': true,
    },
    {
      'name': 'Project Deadline',
      'time': '11:59 PM',
      'date': '2025-03-18',
      'days': ['Sunday'],
      'isOn': false,
    },
    {
      'name': 'Team Meeting',
      'time': '03:00 PM',
      'date': '2025-03-19',
      'days': ['Monday', 'Friday'],
      'isOn': true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: 340,
                          height: 260,
                          padding: EdgeInsets.all(16),
                          child: EditReminderScreen(reminder: reminders[index]),
                        ),
                      ),
                    );
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminders[index]['name'],
                        style: MyStyles.alarmLabelStyle,
                      ),
                      Text(
                        reminders[index]['time'],
                        style: MyStyles.alarmTimeStyle,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminders[index]['date'],
                        style: MyStyles.alarmChallengeStyle,
                      ),
                      Text(
                        reminders[index]['days'].join(', '),
                        style: MyStyles.alarmChallengeStyle,
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: reminders[index]['isOn'],
                    activeTrackColor: MyStyles.myPurple,
                    onChanged: (bool value) {
                      setState(() {
                        reminders[index]['isOn'] = value;
                      });
                    },
                  ),
                ),
              );
            },
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            bottom: 8,
            right: 16,
            width: isFabVisible ? 56 : MediaQuery.of(context).size.width - 32,
            height: 56,
            child: ElevatedButton(
              style: MyStyles.addButton(isFabVisible),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 340,
                      height: 300,
                      padding: EdgeInsets.all(16),
                      child: AddReminderScreen(),
                    ),
                  ),
                );
              },
              child: isFabVisible
                  ? Icon(
                Icons.add_alert,
                color: Colors.white,
                size: 24,
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_alert, color: Colors.white, size: 24),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "Add Reminder",
                      style: MyStyles.normalText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}