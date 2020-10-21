import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/colors.dart';
import 'package:inz_pills/Utils/imageAssets.dart';

class PillsHomeScreenWidget extends StatefulWidget {
  @override
  _PillsHomeScreenWidgetState createState() => _PillsHomeScreenWidgetState();
}

class _PillsHomeScreenWidgetState extends State<PillsHomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 150,
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.powderBlue,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: shadowList),
              ),
              Align(
                child: Image.asset(
                  'images/medicine.png',
                  height: 80,
                ),
              )
            ],
          )),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
              ),
            ),
          )
        ],
      ),
    );
  }
}
