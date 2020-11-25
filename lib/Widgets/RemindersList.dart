import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Reminder.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Widgets/RemindersListTileWidget.dart';
import 'package:provider/provider.dart';

class RemindersList extends StatefulWidget {
  @override
  _RemindersListState createState() => _RemindersListState();
}

class _RemindersListState extends State<RemindersList> {
  @override
  Widget build(BuildContext context) {
    final userReminders = Provider.of<List<Reminder>>(context);
    if (userReminders != null) {
      userReminders.sort((a, b) => a.date.compareTo(b.date));
    }
    return userReminders == null
        ? Loading()
        : ListView.builder(
            itemCount: userReminders.length < 5 ? userReminders.length : 5,
            itemBuilder: (context, index) {
              return RemindersListTileWidget(userReminders[index]);
            });
  }
}
