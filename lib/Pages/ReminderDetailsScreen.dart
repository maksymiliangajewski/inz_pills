import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Reminder.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/LocalNotifications.dart';
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:inz_pills/Widgets/ReminderEditPanel.dart';

class ReminderDetailsScreen extends StatefulWidget {
  final Reminder reminder;

  ReminderDetailsScreen(this.reminder);

  @override
  _ReminderDetailsScreenState createState() => _ReminderDetailsScreenState();
}

class _ReminderDetailsScreenState extends State<ReminderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.caladonBlue,
        ),
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
                      color: AppColors.honeydew,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            color: AppColors.honeydew,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReminderEditPanel(widget.reminder.reminderId)));
                            }),
                        SizedBox(width: 20),
                        IconButton(
                            icon: Icon(Icons.delete),
                            color: AppColors.imperialRed,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(StringAssets.removingReminder),
                                      content: Text(StringAssets.areYouSureToDelete),
                                      actions: [
                                        FlatButton(
                                          child: Text(StringAssets.yes,
                                              style: TextStyle(color: AppColors.imperialRed)),
                                          onPressed: () {
                                            DatabaseService()
                                                .deleteUserReminder(widget.reminder.reminderId);
                                            LocalNotifications.cancelAllNotifications();
                                            LocalNotifications.loadNotifications(
                                                widget.reminder.userId);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text(StringAssets.no,
                                              style: TextStyle(color: AppColors.prussianBlue)),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ],
                                    );
                                  });
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height,
                            margin: EdgeInsets.only(top: size.height * 0.13),
                            decoration: BoxDecoration(
                              color: AppColors.honeydew,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: size.height * 0.07),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(StringAssets.reminderDetails,
                                            style:
                                                TextStyle(color: AppColors.honeydew, fontSize: 30)),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringAssets.title,
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.reminder.title,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        StringAssets.content,
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.reminder.content,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        StringAssets.when,
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.reminder.getDateTimeString(),
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
