import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Models/Reminder.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Widgets/ReminderEditPanel.dart';
import 'package:inz_pills/Widgets/RemindersList.dart';
import 'package:provider/provider.dart';

class RemindersListScreen extends StatefulWidget {
  @override
  _RemindersListScreenState createState() => _RemindersListScreenState();
}

class _RemindersListScreenState extends State<RemindersListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Reminder>>.value(
      value: DatabaseService(uid: user.uid).userReminders,
      child: Material(
        child: Container(
          decoration: BoxDecoration(color: AppColors.honeydew),
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      'List of your reminders',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        icon: Icon(FontAwesomeIcons.plusCircle),
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ReminderEditPanel(null)));
                          // DatabaseService(uid: user.uid).createUserReminder(
                          //     user.uid, 'Created reminder', 'Created content', Timestamp.now());
                        })
                  ],
                ),
              ),
              Expanded(
                child: RemindersList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
