import 'package:challenge_alarm/utils/alarm_utils.dart';
import 'package:challenge_alarm/utils/user_manager.dart';
import 'package:flutter/material.dart';

import '../base/my_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late var size;
  //initial selected index
  int selected_snooze = 1;
  int selected_check_awake = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: SizedBox()),
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: QRCodeWidget(data: UserManager.getUserId()),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          PressShrinkButton(
            onPressed: () {},
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: MyStyles.myPurple,
              ),
              child: Container(
                padding: EdgeInsets.zero,
                width: size.width * 0.68,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.print, color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text(
                      "Print",
                      style: MyStyles.head2.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Container(
            width: size.width * 0.8,
            height: 300,

            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),

            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Snooze Time",
                            style: MyStyles.alarmTimeStyle.copyWith(
                              color: MyStyles.myPurple,
                            ),
                          ),
                          Text(
                            "Choose when you want a snoozed alarm to ring",
                            style:
                                UserManager.isDarkTheme
                                    ? MyStyles.alarmLabelStyle.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                    )
                                    : MyStyles.alarmLabelStyle,
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              5,
                              (index) => ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selected_snooze = index;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  elevation: (selected_snooze == index) ? 5 : 0,
                                  shadowColor: MyStyles.myPurple,
                                  backgroundColor:
                                      (selected_snooze == index)
                                          ? MyStyles.myPurple
                                          : Colors.transparent,
                                  foregroundColor:
                                      (selected_snooze == index)
                                          ? Colors.white
                                          : MyStyles.myPurple,
                                ),
                                child: Text(snooze_times[index].toString()),
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  height: 3,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Awake Alert",
                            style: MyStyles.alarmTimeStyle.copyWith(
                              color: MyStyles.myPurple,
                            ),
                          ),
                          Text(
                            "Enable to get a notification. If ignored, alarm repeats",
                            style:
                                UserManager.isDarkTheme
                                    ? MyStyles.alarmLabelStyle.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                    )
                                    : MyStyles.alarmLabelStyle,
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              5,
                              (index) => ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selected_check_awake = index;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  elevation:
                                      (selected_check_awake == index) ? 5 : 0,
                                  shadowColor: MyStyles.myPurple,
                                  backgroundColor:
                                      (selected_check_awake == index)
                                          ? MyStyles.myPurple
                                          : Colors.transparent,
                                  foregroundColor:
                                      (selected_check_awake == index)
                                          ? Colors.white
                                          : MyStyles.myPurple,
                                ),
                                child: Text(
                                  check_awake_times[index].toString(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
