import 'package:flutter/material.dart';

import '../utils/alarm_utils.dart';
import 'my_styles.dart';

final List<Challenge> challenges = [
  Challenge(
    name: "Math Quiz",
    description: "Solve a math problem to turn off the alarm.",
    imageUrl: "https://via.placeholder.com/150",
    optCount: 3,
    optNames: ['Easy', 'Medium', 'Hard'],
  ),
  Challenge(
    name: "Retype Words",
    description: "Retype the given sentence exactly as shown.",
    imageUrl: "https://via.placeholder.com/150",
    optCount: 2,
    optNames: ['Small', 'Large'],
  ),
  Challenge(
    name: "Captcha",
    description: "Retype the random characters in the image.",
    imageUrl: "https://via.placeholder.com/150",
    optCount: 2,
    optNames: ['Simple', 'With Case'],
  ),
  Challenge(
    name: "Scan QR Code",
    description: "Scan your unique QR code to stop the alarm.",
    imageUrl: "https://via.placeholder.com/150",
    optCount: 0,
    optNames: [],
  ),
  Challenge(
    name: "Random",
    description: "A random challenge will be selected for you!",
    imageUrl: "https://via.placeholder.com/150",
    optCount: 0,
    optNames: [],
  ),
];

class ChallengeMode extends StatelessWidget {
  final String name;
  final bool isSelected;
  final double width;

  const ChallengeMode({
    super.key,
    required this.name,
    required this.isSelected,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: isSelected ? BorderRadius.circular(8) : BorderRadius.zero,
      ),
      child: Center(child: Text(name)),
    );
  }
}

class ChallengeCard extends StatefulWidget {
  final Challenge challenge;

  const ChallengeCard({super.key, required this.challenge});

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  int selectedIndex = 0; // Initially index 0 is selected

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int cnt = widget.challenge.optCount;
    double modeSize = (size.width * 0.8) / cnt;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
      width: size.width * 0.95,
      height: cnt > 0 ? 140 : 80,
      child: Container(
        margin: EdgeInsets.only(left: 24),
        padding: EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.challenge.name,
              style: MyStyles.alarmTimeStyle.copyWith(
                fontSize: 22,
                color: MyStyles.myPurple,
              ),
            ),
            Text(widget.challenge.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            if (cnt > 0)
              SizedBox(height: 10),
            if (cnt > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 40,
              width: size.width * 0.83,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: selectedIndex * modeSize,
                    top: 5,
                    child: Container(
                      width: modeSize,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(cnt, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                widget.challenge.optNames[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      selectedIndex == index
                                          ? Colors.black
                                          : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
