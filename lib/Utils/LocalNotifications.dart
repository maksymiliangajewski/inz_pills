import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
    print(title);
    print(DateTime.now());
    print(scheduledDate.add(Duration(hours: 1)));
    if (takeTime.isBefore(DateTime.now())) {
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
    DatabaseService(uid: uid).getUserDosagesList().then((value) {
      List<Dosage> dosagesList = [];
      value.forEach((element) {
        Dosage dosage = new Dosage(
            userId: element.userId,
            medicine: element.medicine,
            medLink: element.medLink,
            dose: element.dose,
            takeTime: element.takeTime);
        dosagesList.add(dosage);
      });
      dosagesList.forEach((element) async {
        await showNotificationFromList(element.hashCode, element.medicine, element.dose,
            DateTime.fromMillisecondsSinceEpoch(element.takeTime.seconds * 1000).toLocal());
      });
    });
  }

  Future cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
