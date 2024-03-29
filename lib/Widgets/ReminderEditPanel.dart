import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Models/Reminder.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Utils/LocalNotifications.dart';
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:provider/provider.dart';

class ReminderEditPanel extends StatefulWidget {
  final String reminderId;

  ReminderEditPanel(this.reminderId);

  @override
  _ReminderEditPanelState createState() => _ReminderEditPanelState();
}

class _ReminderEditPanelState extends State<ReminderEditPanel> {
  final _formKey = GlobalKey<FormState>();

  String _currentTitle;
  String _currentContent;
  DateTime _currentDate;
  TimeOfDay _currentTime;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _currentTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if (widget.reminderId == null) {
      return createReminder(user);
    } else {
      return updateReminder();
    }
  }

  Widget createReminder(MyUser user) {
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(null);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(StringAssets.createReminder),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration(StringAssets.title),
                    validator: (val) => val.isEmpty ? StringAssets.pleaseEnterValidTitle : null,
                    onChanged: (val) => setState(() => _currentTitle = val),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    maxLines: 6,
                    decoration: textInputDecoration(StringAssets.content),
                    validator: (val) => val.isEmpty ? StringAssets.pleaseEnterValidContent : null,
                    onChanged: (val) => setState(() => _currentContent = val),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(StringAssets.date +
                        '${_currentDate.day}.${_currentDate.month}.${_currentDate.year}'),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickDate,
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(StringAssets.time + '${_currentTime.hour}:${_currentTime.minute}'),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickTime,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: AppColors.prussianBlue,
                        child: Text(
                          StringAssets.create,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService().createUserReminder(
                                user.uid,
                                _currentTitle,
                                _currentContent,
                                Timestamp.fromDate(DateTime(_currentDate.year, _currentDate.month,
                                    _currentDate.day, _currentTime.hour, _currentTime.minute)));
                            LocalNotifications.cancelAllNotifications();
                            LocalNotifications.loadNotifications(user.uid);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      RaisedButton(
                          color: AppColors.imperialRed,
                          child: Text(StringAssets.cancel, style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context))
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget updateReminder() {
    return Material(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: StreamBuilder<Reminder>(
            stream: DatabaseService(reminderId: widget.reminderId).reminderData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Reminder reminderData = snapshot.data;
                return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(StringAssets.updateReminder),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: reminderData.title,
                          decoration: textInputDecoration(StringAssets.title),
                          validator: (val) =>
                              val.isEmpty ? StringAssets.pleaseEnterValidTitle : null,
                          onChanged: (val) => setState(() => _currentTitle = val),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          maxLines: 6,
                          initialValue: reminderData.content,
                          decoration: textInputDecoration(StringAssets.content),
                          validator: (val) =>
                              val.isEmpty ? StringAssets.pleaseEnterValidContent : null,
                          onChanged: (val) => setState(() => _currentContent = val),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          title: Text(StringAssets.date +
                              '${_currentDate.day}.${_currentDate.month}.${_currentDate.year}'),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _pickDate,
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          title: Text(
                              StringAssets.time + '${_currentTime.hour}:${_currentTime.minute}'),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          onTap: _pickTime,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              color: AppColors.prussianBlue,
                              child: Text(
                                StringAssets.update,
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await DatabaseService(reminderId: reminderData.reminderId)
                                      .updateUserReminder(
                                          reminderData.reminderId,
                                          reminderData.userId,
                                          _currentTitle ?? reminderData.title,
                                          _currentContent ?? reminderData.content,
                                          Timestamp.fromDate(DateTime(
                                                  _currentDate.year,
                                                  _currentDate.month,
                                                  _currentDate.day,
                                                  _currentTime.hour,
                                                  _currentTime.minute)) ??
                                              reminderData.date);
                                  LocalNotifications.cancelAllNotifications();
                                  LocalNotifications.loadNotifications(reminderData.userId);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            RaisedButton(
                                color: AppColors.imperialRed,
                                child: Text(StringAssets.cancel,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () => Navigator.pop(context)),
                          ],
                        ),
                      ],
                    ));
              } else {
                return Loading();
              }
            },
          )),
    );
  }

  void _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _currentDate,
    );
    if (date != null)
      setState(() {
        _currentDate = date;
      });
  }

  void _pickTime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _currentTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (time != null)
      setState(() {
        _currentTime = time;
      });
  }
}
