import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserManager {
  static const String _userIdKey = 'user_id';
  static String? userId;
  static bool isDarkTheme = true;

  // Call this in main before runApp
  static Future<void> initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(_userIdKey);

    if (userId == null) {
      userId = const Uuid().v4();
      await prefs.setString(_userIdKey, userId!);
    } else {
    }
  }

  static String getUserId() {
    return userId!;
  }
}

class QRCodeWidget extends StatelessWidget {
  final String data;

  const QRCodeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: data,
        version: QrVersions.auto,
        size: 250.0,
        eyeStyle: QrEyeStyle(color: UserManager.isDarkTheme? ThemeData.light().colorScheme.surface: Colors.black, eyeShape: QrEyeShape.square),
        dataModuleStyle: QrDataModuleStyle(
          color: UserManager.isDarkTheme? ThemeData.light().colorScheme.surface: Colors.black,
          dataModuleShape: QrDataModuleShape.circle,
        ),
        embeddedImage: AssetImage("assets/challenge_alarm_logo_bordered_qr.png"),
        embeddedImageStyle: QrEmbeddedImageStyle(size: Size(45, 45)),
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      ),
    );
  }
}
