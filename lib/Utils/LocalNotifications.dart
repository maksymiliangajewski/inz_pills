import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoder/geocoder.dart';
import 'package:inz_pills/Models/Appointment.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  BuildContext context;

  void initializeSettings(BuildContext ctx) {
    context = ctx;
    tz.initializeTimeZones();
    var androidInitialize = new AndroidInitializationSettings('notification_icon');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings =
        new InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      List<String> payloadSplitted = payload.split('===');
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(payloadSplitted[0]),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(payloadSplitted[1]),
                ),
              ));
    });
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
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          payload: title + '===' + body);
    }
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
    print('loading reminders');
    DatabaseService(uid: uid).getUserAppointmentsList().then((value) {
      List<Appointment> appointmentsList = [];
      value.forEach((element) {
        Appointment appointment = new Appointment(
            userId: element.userId,
            date: element.date,
            doctorName: element.doctorName,
            doctorSpecialisation: element.doctorSpecialisation,
            location: element.location);
        appointmentsList.add(appointment);
      });
      appointmentsList.forEach((element) async {
        final coordinates = new Coordinates(element.location.latitude, element.location.longitude);
        var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        Address locationAddress = address.first;
        await showNotificationFromList(
            element.hashCode,
            element.doctorSpecialisation + ' - ' + element.doctorName,
            element.getDateTimeString() + '\n' + locationAddress.addressLine,
            DateTime.fromMillisecondsSinceEpoch(element.date.seconds * 1000)
                .toLocal()
                .subtract(Duration(hours: 2)));
      });
    });
  }

  Future cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
