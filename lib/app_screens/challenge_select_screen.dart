import 'package:challenge_alarm/base/my_styles.dart';
import 'package:flutter/material.dart';

import '../base/challenge_utils.dart';

class ChallengeSelectScreen extends StatefulWidget {
  const ChallengeSelectScreen({super.key});

  @override
  State<ChallengeSelectScreen> createState() => _ChallengeSelectScreenState();
}

class _ChallengeSelectScreenState extends State<ChallengeSelectScreen> {
  int? _selectedChallengeIndex;
  final int numChallenges = challenges.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          "Choose a challenge",
          style: MyStyles.head2,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(numChallenges, (index) => ChallengeCard(challenge: challenges[index],)),
      )

    );
  }

}

