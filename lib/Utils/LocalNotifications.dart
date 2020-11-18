import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

List<Dosage> dosageList = [
  new Dosage(
      dose: '1 tabletka',
      medicine: 'Polopiryna',
      takeTime: Timestamp.fromDate(DateTime.now().add(Duration(seconds: 5)))),
  new Dosage(
      dose: '1 tabletka',
      medicine: 'Aspiryna',
      takeTime: Timestamp.fromDate(DateTime.now().add(Duration(seconds: 10)))),
  new Dosage(
      dose: '1 tabletka',
      medicine: 'Ipubrom',
      takeTime: Timestamp.fromDate(DateTime.now().add(Duration(seconds: 15)))),
  new Dosage(
      dose: '1 psik',
      medicine: 'Nasonexxxxx',
      takeTime: Timestamp.fromDate(DateTime.now().add(Duration(seconds: 20)))),
];

class LocalNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initializeSettings() {
    tz.initializeTimeZones();
    var androidInitialize = new AndroidInitializationSettings('notification_icon');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings =
        new InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future showNotificationFromList(
      int hashcode, String title, String body, DateTime takeTime) async {
    final scheduledDate = tz.TZDateTime.from(takeTime, tz.local);
    if (scheduledDate.isBefore(DateTime.now())) {
      print('date in the past, cannot add');
      print(takeTime);
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          hashcode,
          title,
          body,
          scheduledDate,
          NotificationDetails(
              android: AndroidNotificationDetails(
                'id',
                'channelName',
                'channelDesc',
                importance: Importance.max,
              ),
              iOS: IOSNotificationDetails()),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future showNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Prompted notification title',
        'Prompted notification body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(
            android: AndroidNotificationDetails(
              'Some ID',
              'Flutter notifications app',
              'Testing notifications',
              importance: Importance.max,
            ),
            iOS: IOSNotificationDetails()),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  void loadNotifications(String uid) {
    print('loading notifications');
    // DatabaseService(uid: uid).getUserDosagesList().then((value) {
    //   List<Dosage> dosagesList = [];
    //   value.forEach((element) {
    //     Dosage dosage = new Dosage(
    //         userId: element.userId,
    //         medicine: element.medicine,
    //         medLink: element.medLink,
    //         dose: element.dose,
    //         takeTime: element.takeTime);
    //     dosagesList.add(dosage);
    //   });
    //   dosagesList.forEach((element) async {
    //     await _showNotificationsFromList(
    //         element.hashCode,
    //         element.medicine,
    //         element.dose,
    //         DateTime.fromMillisecondsSinceEpoch(element.takeTime.seconds * 1000)
    //             .add(Duration(hours: 1)));
    //   });
    // });

    dosageList.forEach((element) async {
      await showNotificationFromList(element.hashCode, element.medicine, element.dose,
          DateTime.fromMillisecondsSinceEpoch(element.takeTime.seconds * 1000));
    });
  }

  Future cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
