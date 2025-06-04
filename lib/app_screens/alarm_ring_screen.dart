import 'package:challenge_alarm/base/my_styles.dart';
import 'package:challenge_alarm/utils/alarm_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmRingScreen extends StatefulWidget {
  const AlarmRingScreen({super.key});

  @override
  State<AlarmRingScreen> createState() => _AlarmRingScreenState();
}

class _AlarmRingScreenState extends State<AlarmRingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(flex: 6, child: SizedBox()),
            Column(
              children: [
                Text(
                  "08 : 00",
                  style: GoogleFonts.openSans(
                    fontSize: 72,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                    color: MyStyles.myPurple,
                  ),
                ),
                Text("Morning Run", style: MyStyles.head2),
              ],
            ),
            Expanded(flex: 18, child: SizedBox()),
            PressShrinkButton(
              onPressed: () {},
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyStyles.myPurple,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Snooze",
                    style: GoogleFonts.openSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(flex: 5, child: SizedBox()),
            Text("Swipe up to Dismiss", style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
              color: Colors.grey,
            ),),
            Expanded(flex: 1, child: SizedBox()),

          ],
        ),
      ),
    );
  }
}
