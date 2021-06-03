import 'package:calendar_time/calendar_time.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Utils/Colors.dart';

class HomeScreenDosagesListTileWidget extends StatefulWidget {
  final Dosage dosage;

  HomeScreenDosagesListTileWidget({this.dosage});

  @override
  _HomeScreenDosagesListTileWidgetState createState() =>
      _HomeScreenDosagesListTileWidgetState();
}

class _HomeScreenDosagesListTileWidgetState
    extends State<HomeScreenDosagesListTileWidget> {
  Color color;

  @override
  void initState() {
    super.initState();
    color = customizeTileByDate();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: shadowList),
                ),
                Align(
                  child: Image.asset(
                    'images/medicine.png',
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
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.dosage.medicine,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(widget.dosage.dose),
                    SizedBox(height: 10),
                    Text(widget.dosage.getDateTimeString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color customizeTileByDate() {
    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final takeTime = DateTime.fromMillisecondsSinceEpoch(
            widget.dosage.takeTime.seconds * 1000)
        .toLocal();

    if (takeTime.difference(now).inSeconds < 0) {
      // date in the past
      return Colors.red;
    } else if (takeTime.difference(now).inSeconds > 0) {
      if (takeTime.difference(endOfToday).inSeconds < 0) {
        // today
        return Colors.green;
      } else if (CalendarTime(takeTime).isTomorrow) {
        // tomorrow
        return Colors.teal;
      } else {
        // some day in the future
        return Colors.blue;
      }
    } else {
      // NOW
      return Colors.black;
    }
  }
}
