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
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:inz_pills/Widgets/UserEditPanel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
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
                    CircleAvatar(
                      child: ClipRect(
                        child: Image.asset(
                          'images/avatar.png',
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                    ),
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
                              StringAssets.editUserInfo,
                              style: TextStyle(
                                color: AppColors.honeydew,
                              ),
                            )
                          ],
                        ),
                        onTap: () => _showUserEditPanel(),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.info,
                              color: AppColors.honeydew,
                            ),
                            SizedBox(width: 10),
                            Text(
                              StringAssets.howManyNotifications,
                              style: TextStyle(
                                color: AppColors.honeydew,
                              ),
                            )
                          ],
                        ),
                        onTap: () async {
                          final List<PendingNotificationRequest> pendingNotificationRequests =
                              await LocalNotifications.flutterLocalNotificationsPlugin
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
                            msg: '${pendingNotificationRequests.length}' +
                                StringAssets.numberOfNotificationsLoaded,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RaisedButton(
                      child: Text(
                        StringAssets.logOut,
                        style: TextStyle(color: AppColors.imperialRed, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        LocalNotifications.cancelAllNotifications();
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
