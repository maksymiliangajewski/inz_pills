import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/LocalNotifications.dart';
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
  final LocalNotifications _notifications = LocalNotifications();
  bool showNotifications;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _notifications.initializeSettings();
    print('notifications settings initialized');
    _notifications.cancelAllNotifications();
    showNotifications = widget.showNotifications;
    if (widget.showNotifications) {
      _notifications.loadNotifications(widget.uid);
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
                        'Inzynierka App',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final List<PendingNotificationRequest> pendingNotificationRequests =
                        await _notifications.flutterLocalNotificationsPlugin
                            .pendingNotificationRequests();
                    print(pendingNotificationRequests.length);
                    pendingNotificationRequests.forEach((element) {
                      print(element.id.toString() +
                          ' ' +
                          element.title.toString() +
                          ' ' +
                          element.body.toString() +
                          ' ' +
                          element.payload);
                    });
                    Fluttertoast.showToast(
                      msg:
                          "${pendingNotificationRequests.length} Notifications loaded from database",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.add),
                            Text('New reminder'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Notifications'),
                            Switch(
                                value: showNotifications,
                                onChanged: (value) async {
                                  if (value) {
                                    _notifications.cancelAllNotifications();
                                    _notifications.loadNotifications(widget.uid);
                                    Fluttertoast.showToast(
                                      msg: 'Notifications has just been reloaded!',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  } else {
                                    _notifications.cancelAllNotifications();
                                    Fluttertoast.showToast(
                                      msg: 'All your notifications are now muted.',
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
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomePageButton('Medication', 'drugs.png'),
                      HomePageButton('Dosages', 'doctor.png'),
                      HomePageButton('Search', 'magnifying-glass.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Your upcoming dosages',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(child: HomeScreenDosagesList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
