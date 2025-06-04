import 'package:challenge_alarm/base/bottom_nav_bar.dart';
import 'package:challenge_alarm/base/my_styles.dart';
import 'package:challenge_alarm/utils/user_manager.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserManager.initializeUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyStyles.myPurple),
      ),
      home: BottomNavBar(),
    );
  }
}