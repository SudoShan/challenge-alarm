import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';

class EditReminderScreen extends StatefulWidget {
  final Map<String, dynamic> reminder;

  const EditReminderScreen({super.key, required this.reminder});

  @override
  State<EditReminderScreen> createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  late TextEditingController labelController;
  late TimeOfDay selectedTime;
  late List<String> selectedDays;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.reminder['name']);
    selectedTime = _parseTime(widget.reminder['time']);
    selectedDays = List<String>.from(widget.reminder['days']);
  }

  TimeOfDay _parseTime(String timeString) {
    final TimeOfDay time = TimeOfDay(
      hour: int.parse(timeString.split(":")[0]),
      minute: int.parse(timeString.split(":")[1].split(" ")[0]),
    );
    return time;
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

  void _toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    List<String> fullDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Edit Reminder", style: MyStyles.dialogHead),
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
                  const Text("Time: "),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(selectedTime.format(context)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: labelController,
            decoration: MyStyles.myInputDecoration("Reminder Name"),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              bool isSelected = selectedDays.contains(fullDays[index]);
              return GestureDetector(
                onTap: () => _toggleDay(fullDays[index]),
                child: CircleAvatar(
                  backgroundColor: isSelected ? MyStyles.myPurple : Colors.grey[300],
                  child: Text(
                    daysOfWeek[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [Icon(Icons.delete), SizedBox(width: 5), Text("Delete")],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': labelController.text,
                    'time': selectedTime.format(context),
                    'days': selectedDays,
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