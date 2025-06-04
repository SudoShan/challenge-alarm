import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';

import '../base/challenge_utils.dart';
import '../utils/alarm_utils.dart';

class EditChallengeScreen extends StatefulWidget {
  final int initialChallengeIndex;

  const EditChallengeScreen({super.key, required this.initialChallengeIndex});

  @override
  State<EditChallengeScreen> createState() => _EditChallengeScreenState();
}

class _EditChallengeScreenState extends State<EditChallengeScreen> {
  late int _selectedChallengeIndex;

  @override
  void initState() {
    super.initState();
    _selectedChallengeIndex = widget.initialChallengeIndex; // Set initial selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit your challenge", style: MyStyles.head2),
            Expanded(
              child: ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  final isSelected = (index == _selectedChallengeIndex);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedChallengeIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyStyles.lightPurple,
                        border: isSelected
                            ? Border.all(color: Colors.deepPurple, width: 3)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 6,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              challenges[index].name,
                              style: MyStyles.alarmTimeStyle.copyWith(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(challenges[index].description),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, challenges[_selectedChallengeIndex]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
