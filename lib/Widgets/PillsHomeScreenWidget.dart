import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Utils/Colors.dart';

class PillsHomeScreenWidget extends StatefulWidget {
  final Dosage dosage;

  PillsHomeScreenWidget({this.dosage});

  @override
  _PillsHomeScreenWidgetState createState() => _PillsHomeScreenWidgetState();
}

class _PillsHomeScreenWidgetState extends State<PillsHomeScreenWidget> {
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
                      color: AppColors.powderBlue,
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
                        topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.dosage.medicine,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(widget.dosage.userId),
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
