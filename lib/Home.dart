import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/MyUser.dart';
import 'Pages/DrawerScreen.dart';
import 'Pages/HomeScreen.dart';
import 'Utils/Loading.dart';
import 'Utils/LocalNotifications.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalNotifications _notifications = LocalNotifications();

    Future<bool> _getShowingNotificationsInfo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool result = prefs.getBool('showNotifications');
      if (result == null) {
        print('first run, setting showing notifications to true');
        result = true;
      }
      return result;
    }

    final user = Provider.of<MyUser>(context);
    return FutureBuilder<bool>(
      future: _getShowingNotificationsInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('snapshot data on home: ' + snapshot.data.toString());
          bool showNotifications = snapshot.data;
          return Scaffold(
            body: Stack(
              children: [
                DrawerScreen(notifs: _notifications),
                HomeScreen(
                  uid: user.uid,
                  showNotifications: showNotifications,
                  notifs: _notifications,
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
