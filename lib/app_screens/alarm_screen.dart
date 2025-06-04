import 'package:challenge_alarm/app_screens/add_alarm_screen.dart';
import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'edit_alarm_screen.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final ScrollController scrollController = ScrollController();
  bool isFabVisible = false; // To track the button state

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isFabVisible) {
          setState(() {
            isFabVisible = true;
          });
        }
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
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

  List<Map<String, dynamic>> alarms = [
    {
      'time': '07:00 AM',
      'date': '2025-03-16',
      'isOn': true,
      'label': 'WakeUp',
      'challenge': 'Math Quiz',
      'repeatDays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'ringtone': 'Early Bird',
      'checkAwake': true,
      'vibrate': true,
      'days': [false, true, true, true, true, true, false], // Mon-Fri
    },
    {
      'time': '06:30 AM',
      'date': '2025-03-17',
      'isOn': true,
      'label': 'Morning Run',
      'challenge': 'Random',
      'repeatDays': ['Tue', 'Thu', 'Sat'],
      'ringtone': 'Morning Breeze',
      'checkAwake': false,
      'vibrate': true,
      'days': [false, false, true, false, true, false, true], // Tue, Thu, Sat
    },
    {
      'time': '07:45 AM',
      'date': '2025-03-18',
      'isOn': false,
      'label': 'Work Alarm',
      'challenge': 'Captcha',
      'repeatDays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'ringtone': 'Office Bell',
      'checkAwake': true,
      'vibrate': false,
      'days': [false, true, true, true, true, true, false], // Mon-Fri
    },
    {
      'time': '08:00 AM',
      'date': '2025-03-19',
      'isOn': true,
      'label': 'Gym',
      'challenge': 'Math Quiz',
      'repeatDays': ['Mon', 'Wed', 'Fri'],
      'ringtone': 'Power Up',
      'checkAwake': true,
      'vibrate': true,
      'days': [false, true, false, true, false, true, false], // Mon, Wed, Fri
    },
    {
      'time': '09:15 AM',
      'date': '2025-03-20',
      'isOn': true,
      'label': 'Meeting',
      'challenge': 'Random',
      'repeatDays': ['Thu'],
      'ringtone': 'Alert Tone',
      'checkAwake': false,
      'vibrate': true,
      'days': [false, false, false, false, true, false, false], // Thu
    },
    {
      'time': '10:30 AM',
      'date': '2025-03-21',
      'isOn': false,
      'label': 'Medicine Reminder',
      'challenge': 'Captcha',
      'repeatDays': ['Mon', 'Wed', 'Fri', 'Sun'],
      'ringtone': 'Soft Bell',
      'checkAwake': false,
      'vibrate': false,
      'days': [true, true, false, true, false, true, false], // Sun, Mon, Wed, Fri
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: 460,
                            padding: const EdgeInsets.all(16),
                            child: EditAlarmScreen(alarm: alarms[index]),
                          ),
                        );
                      },
                    );
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alarms[index]['label'],
                        style: MyStyles.alarmLabelStyle,
                      ),
                      Text(
                        alarms[index]['time'],
                        style: MyStyles.alarmTimeStyle,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        alarms[index]['challenge'],
                        style: MyStyles.alarmChallengeStyle,
                      ),
                      SizedBox(width: 10),
                      Text(alarms[index]['date']),
                    ],
                  ),
                  trailing: Switch(
                    value: alarms[index]['isOn'],
                    activeTrackColor: MyStyles.myPurple,
                    onChanged: (bool value) {
                      setState(() {
                        alarms[index]['isOn'] = value;
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
            right: 16, // Keep margins
            width: isFabVisible ? 56 : MediaQuery.of(context).size.width - 32, // Shrink or expand
            height: 56, // Keep height fixed
            child: ElevatedButton(
              style: MyStyles.addButton(isFabVisible),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        height: 460,
                        padding: const EdgeInsets.all(16),
                        child: const AddAlarmScreen(),
                      ),
                    );
                  },
                );
              },

              child:
                  isFabVisible
                      ? Icon(
                        Icons.alarm_add,
                        color: Colors.white,
                        size: 24,
                      ) // Show icon when FAB
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm_add, color: Colors.white, size: 24),
                          SizedBox(width: 10,),
                          Flexible( // Ensure text shrinks properly
                            child: Text(
                              "Add Alarm",
                              style: MyStyles.normalText,
                              overflow: TextOverflow.ellipsis, // Prevents overflow by truncating text
                            ),
                          ),
                        ],
                      ), // Full width text
            ),
          ),
        ],
      ),
    );
  }
}
