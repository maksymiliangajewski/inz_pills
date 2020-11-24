import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Auth.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Utils/LocalNotifications.dart';
import 'package:inz_pills/Widgets/UserEditPanel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  final LocalNotifications notifs;

  const DrawerScreen({Key key, this.notifs}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final AuthService _auth = AuthService();
  LocalNotifications _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = widget.notifs;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    void _showUserEditPanel() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditPanel()));
    }

    return StreamBuilder<MyUser>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MyUser userData = snapshot.data;
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.prussianBlue, AppColors.caladonBlue])),
            padding: EdgeInsets.only(top: 60, left: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 10),
                    Text(
                      '${userData.name} ${userData.surname}',
                      style: TextStyle(color: AppColors.honeydew, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userAlt,
                              color: AppColors.honeydew,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Edit user info',
                              style: TextStyle(
                                color: AppColors.honeydew,
                              ),
                            )
                          ],
                        ),
                        onTap: () => _showUserEditPanel(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.baby,
                              color: AppColors.honeydew,
                            ),
                            SizedBox(width: 10),
                            Text('Menu 2',
                                style: TextStyle(
                                  color: AppColors.honeydew,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.facebook,
                              color: AppColors.honeydew,
                            ),
                            SizedBox(width: 10),
                            Text('Menu 3',
                                style: TextStyle(
                                  color: AppColors.honeydew,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.ravelry,
                              color: AppColors.honeydew,
                            ),
                            SizedBox(width: 10),
                            Text('Menu 4',
                                style: TextStyle(
                                  color: AppColors.honeydew,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.cog,
                      color: AppColors.honeydew,
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      onPressed: () async {
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
                      child: Text(
                        'Settings',
                        style: TextStyle(color: AppColors.honeydew, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 20,
                      color: AppColors.honeydew,
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      child: Text(
                        'Log out',
                        style: TextStyle(color: AppColors.imperialRed, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        _notifications.cancelAllNotifications();
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showNotifications', null);
                        await _auth.signOut();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
