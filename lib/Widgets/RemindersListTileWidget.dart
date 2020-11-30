import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Reminder.dart';
import 'package:inz_pills/Pages/ReminderDetailsScreen.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/StringAssets.dart';

class RemindersListTileWidget extends StatefulWidget {
  final Reminder reminder;

  RemindersListTileWidget(this.reminder);

  @override
  _RemindersListTileWidgetState createState() => _RemindersListTileWidgetState();
}

class _RemindersListTileWidgetState extends State<RemindersListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(_createRoute());
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: MediaQuery.of(context).size.width * 0.38,
        child: Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.caladonBlue,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: shadowList),
                ),
                Align(
                  child: Image.asset(
                    'images/consultation.png',
                    width: MediaQuery.of(context).size.width * 0.19,
                  ),
                )
              ],
            )),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowList,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 5),
                      child: Text(
                        widget.reminder.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Text(
                      widget.reminder.getDateTimeString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(StringAssets.clickToSeeDetails),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ReminderDetailsScreen(widget.reminder),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
