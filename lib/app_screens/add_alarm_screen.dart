import 'package:challenge_alarm/app_screens/alarm_ring_screen.dart';
import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';
import '../utils/user_manager.dart';
import 'challenge_select_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  late TimeOfDay selectedTime;
  late TextEditingController labelController;
  List<bool> selectedDays = List.generate(7, (index) => false);
  bool isAwakeCheckEnabled = false;
  bool isVibrateEnabled = false;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay(hour: 6, minute: 0);
    labelController = TextEditingController(text: "No Label");
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Alarm", style: UserManager.isDarkTheme? MyStyles.dialogHead.copyWith(color: MyStyles.foreground): MyStyles.dialogHead),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),

            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: labelController,
            decoration: MyStyles.myInputDecoration("Label"),
            style: UserManager.isDarkTheme? MyStyles.labelTextStyle.copyWith(color: Theme.of(context).colorScheme.onSurface): MyStyles.labelTextStyle,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Ring At ", style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(selectedTime.format(context)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Challenge ", style: TextStyle(color: UserManager.isDarkTheme? MyStyles.foreground : Colors.black),),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChallengeSelectScreen()
                        ),
                      );
                    },
                    child: Text("Select"),
                  ),
                ],
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDays[index] = !selectedDays[index];
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedDays[index]
                        ? MyStyles.myPurple
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyStyles.myPurple),
                  ),
                  child: Text(
                    days[index],
                    style: TextStyle(
                      color: selectedDays[index]
                          ? Colors.white
                          : MyStyles.myPurple,
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 10),

          // New ringtone layout (icon + text inside a TextButton)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AlarmRingScreen(),
                    fullscreenDialog: true,
                  ),
                );
              },
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: Row(
                children: [
                  Icon(Icons.music_note, color: MyStyles.myPurple),
                  SizedBox(width: 8),
                  Text(
                    "Default",
                    style: TextStyle(
                      color: MyStyles.myPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Check if I'm Awake (full width + left aligned)
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  isAwakeCheckEnabled = !isAwakeCheckEnabled;
                });
              },
              icon: Icon(Icons.check_circle,
                  color: isAwakeCheckEnabled
                      ? Colors.white
                      : MyStyles.myPurple),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Check if I'm Awake",
                  style: TextStyle(
                    color: isAwakeCheckEnabled
                        ? Colors.white
                        : MyStyles.myPurple,
                  ),
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor:
                WidgetStateProperty.resolveWith<Color?>((states) {
                  return isAwakeCheckEnabled
                      ? MyStyles.myPurple
                      : Colors.transparent;
                }),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Vibrate (full width + left aligned)
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  isVibrateEnabled = !isVibrateEnabled;
                });
              },
              icon: Icon(Icons.vibration,
                  color:
                  isVibrateEnabled ? Colors.white : MyStyles.myPurple),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Vibrate",
                  style: TextStyle(
                    color:
                    isVibrateEnabled ? Colors.white : MyStyles.myPurple,
                  ),
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor:
                WidgetStateProperty.resolveWith<Color?>((states) {
                  return isVibrateEnabled
                      ? MyStyles.myPurple
                      : Colors.transparent;
                }),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Save button - full width, rounded and centered
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'time': selectedTime.format(context),
                  'label': labelController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyStyles.myPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    labelController.dispose();
    super.dispose();
  }
}
