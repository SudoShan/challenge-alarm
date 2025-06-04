import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/user_manager.dart';

class MyStyles {
  static Color myPurple = Color(0xFF9966CC);
  static Color lightPurple = Color(0xFFF5EAF7);
  static Color foreground = Color(0xD9FFFFFF);

  static TextStyle head1 = GoogleFonts.openSans(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.1,
    color: myPurple,
  );

  static TextStyle head2 = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    color: myPurple,
  );

  static TextStyle ringTime = TextStyle(
    fontSize: 80,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.1,
    color: Colors.white,
  );

  static TextStyle snoozeText = GoogleFonts.openSans(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.1,
    color: Colors.white,
  );

  static TextStyle alarmLabelStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.blueGrey,
  );

  static TextStyle alarmTimeStyle = GoogleFonts.openSans(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    color: Colors.black54,
  );
  static TextStyle alarmChallengeStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: myPurple,
  );

  static TextStyle normalText = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle dialogHead = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle dialogHeadButton = GoogleFonts.openSans(
    fontSize: 18,
    color: myPurple,
  );

  static TextStyle labelTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static ButtonStyle addButton(bool isFabVisible) {
    return ElevatedButton.styleFrom(
      elevation: 5,
      shape:
          isFabVisible
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding:
          isFabVisible
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(vertical: 16),
      backgroundColor: myPurple,
    );
  }

  static InputDecoration myInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: UserManager.isDarkTheme? MyStyles.foreground : Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: myPurple, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
