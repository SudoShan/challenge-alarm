import 'package:challenge_alarm/app_screens/alarm_ring_screen.dart';
import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';
import '../base/challenge_utils.dart';
import '../utils/alarm_utils.dart';
import 'challenge_edit_screen.dart';

class EditAlarmScreen extends StatefulWidget {
  final Map<String, dynamic> alarm;

  const EditAlarmScreen({super.key, required this.alarm});

  @override
  State<EditAlarmScreen> createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends State<EditAlarmScreen> {
  late TextEditingController labelController;
  late TimeOfDay selectedTime;
  late String selectedChallenge;
  List<bool> selectedDays = List.generate(7, (index) => false);
  bool isAwakeCheckEnabled = false;
  bool isVibrateEnabled = false;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.alarm['label']);
    selectedTime = _parseTime(widget.alarm['time']);
    selectedChallenge = widget.alarm['challenge'];
    selectedDays = List<bool>.from(widget.alarm['days'] ?? List.generate(7, (_) => false));
    isAwakeCheckEnabled = widget.alarm['checkAwake'] ?? false;
    isVibrateEnabled = widget.alarm['vibrate'] ?? false;
  }

  TimeOfDay _parseTime(String timeString) {
    final hour = int.parse(timeString.split(":")[0]);
    final minute = int.parse(timeString.split(":")[1].split(" ")[0]);
    return TimeOfDay(hour: hour, minute: minute);
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

  Future<void> _editChallenge(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditChallengeScreen(
          initialChallengeIndex: challenges.indexWhere((c) => c.name == selectedChallenge),
        ),
      ),
    );
    if (result != null) {
      setState(() {
        selectedChallenge = result.name;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Edit Alarm", style: MyStyles.dialogHead),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Label Input
          TextField(
            controller: labelController,
            decoration: MyStyles.myInputDecoration("Label"),
            style: MyStyles.labelTextStyle,
          ),

          SizedBox(height: 10),

          // Time and Challenge Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("Ring At "),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(selectedTime.format(context)),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Challenge "),
                  TextButton(
                    onPressed: () => _editChallenge(context),
                    child: Text(selectedChallenge),
                  ),
                ],
              ),
            ],
          ),

          // Days Row
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
                    color: selectedDays[index] ? MyStyles.myPurple : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyStyles.myPurple),
                  ),
                  child: Text(
                    days[index],
                    style: TextStyle(
                      color: selectedDays[index] ? Colors.white : MyStyles.myPurple,
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 10),

          // Ringtone Picker
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
                  Text("Default", style: TextStyle(color: MyStyles.myPurple)),
                ],
              ),
            ),
          ),

          // Awake Check Toggle
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  isAwakeCheckEnabled = !isAwakeCheckEnabled;
                });
              },
              icon: Icon(
                Icons.check_circle,
                color: isAwakeCheckEnabled ? Colors.white : MyStyles.myPurple,
              ),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Check if I'm Awake",
                  style: TextStyle(
                    color: isAwakeCheckEnabled ? Colors.white : MyStyles.myPurple,
                  ),
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) => isAwakeCheckEnabled ? MyStyles.myPurple : Colors.transparent,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Vibrate Toggle
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  isVibrateEnabled = !isVibrateEnabled;
                });
              },
              icon: Icon(
                Icons.vibration,
                color: isVibrateEnabled ? Colors.white : MyStyles.myPurple,
              ),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Vibrate",
                  style: TextStyle(
                    color: isVibrateEnabled ? Colors.white : MyStyles.myPurple,
                  ),
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) => isVibrateEnabled ? MyStyles.myPurple : Colors.transparent,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Action Buttons (Delete & Save)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, {'delete': true}),
                child: Row(
                  children: [Icon(Icons.delete), SizedBox(width: 5), Text("Delete")],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'time': selectedTime.format(context),
                    'label': labelController.text,
                    'challenge': selectedChallenge,
                    'days': selectedDays,
                    'awakeCheck': isAwakeCheckEnabled,
                    'vibrate': isVibrateEnabled,
                  });
                },
                child: Row(
                  children: [Icon(Icons.check), SizedBox(width: 5), Text("Save")],
                ),
              ),
            ],
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
