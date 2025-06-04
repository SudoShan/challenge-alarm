import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  late TimeOfDay selectedTime;
  bool isRepeatEnabled = false;
  late TextEditingController labelController;
  Map<String, bool> repeatDays = {
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
    'Sun': false,
  };

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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Reminder", style: MyStyles.dialogHead),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("Remind At "),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(selectedTime.format(context)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text("Repeat On"),
          Wrap(
            spacing: 5.0,
            children: repeatDays.keys.map((day) {
              return TextButton(
                onPressed: () {
                  setState(() {
                    repeatDays[day] = !repeatDays[day]!;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    return repeatDays[day]! ? MyStyles.myPurple : Colors.transparent;
                  }),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                child: Text(
                  day,
                  style: TextStyle(
                    color: repeatDays[day]! ? Colors.white : MyStyles.myPurple,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 15),
          TextField(
            controller: labelController,
            decoration: MyStyles.myInputDecoration("Label"),
            style: MyStyles.labelTextStyle,
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'time': selectedTime.format(context),
                'label': labelController.text,
                'repeatDays': repeatDays.entries.where((e) => e.value).map((e) => e.key).toList(),
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.check), SizedBox(width: 5), Text("Save")],
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