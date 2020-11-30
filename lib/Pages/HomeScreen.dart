import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/LocalNotifications.dart';
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:inz_pills/Widgets/HomeScreenDosagesList.dart';
import 'package:inz_pills/widgets/HomePageButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  final bool showNotifications;

  const HomeScreen({Key key, this.uid, this.showNotifications}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showNotifications;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    LocalNotifications.initializeSettings(context);
    print('notifications settings initialized');
    LocalNotifications.cancelAllNotifications();
    showNotifications = widget.showNotifications;
    if (widget.showNotifications) {
      LocalNotifications.loadNotifications(widget.uid);
      print('notifications loaded');
      Fluttertoast.showToast(
        msg: "Notification loaded on start!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Notification are disabled.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Dosage>>.value(
      value: DatabaseService(uid: user.uid).userDosages,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.powderBlue, AppColors.caladonBlue]),
          borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0),
          color: AppColors.honeydew,
        ),
        child: GestureDetector(
          //when DrawerScreen opened, HitTestBehavior.opaque allows to
          // receive click anywhere on HomeScreen widget
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (isDrawerOpen) {
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              });
            }
          },
          // to block accidental clicks when DrawerScreen is opened
          child: IgnorePointer(
            //whenever DrawerScreen is open, all clickable Widgets on HomeScreen are disabled
            ignoring: isDrawerOpen,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerOpen
                          ? IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              })
                          : IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                setState(() {
                                  xOffset = 230;
                                  yOffset = 150;
                                  scaleFactor = 0.6;
                                  isDrawerOpen = true;
                                });
                              }),
                      Text(
                        StringAssets.appTitle,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1, child: HomePageButton(StringAssets.reminders, 'reminders.png')),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(StringAssets.notifications),
                            Switch(
                                value: showNotifications,
                                onChanged: (value) async {
                                  if (value) {
                                    LocalNotifications.cancelAllNotifications();
                                    LocalNotifications.loadNotifications(widget.uid);
                                    Fluttertoast.showToast(
                                      msg: StringAssets.notificationsReloaded,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  } else {
                                    LocalNotifications.cancelAllNotifications();
                                    Fluttertoast.showToast(
                                      msg: StringAssets.notificationsMuted,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('showNotifications', !showNotifications);
                                  setState(() {
                                    showNotifications = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1, child: HomePageButton(StringAssets.medication, 'drugs.png')),
                      Expanded(flex: 1, child: HomePageButton(StringAssets.dosages, 'dosages.png')),
                      Expanded(
                          flex: 1,
                          child: HomePageButton(StringAssets.appointments, 'appointments.png')),
                    ],
                  ),
                ),
                Text(
                  StringAssets.upcomingDosages,
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: Colors.white),
                      child: HomeScreenDosagesList()),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
