import 'package:flutter/material.dart';
import 'package:inz_pills/Pages/MedicineDetailsScreen.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/StringAssets.dart';

class MedicineListTileWidget extends StatefulWidget {
  final String title;
  final String medicineUrl;

  @override
  _MedicineListTileWidgetState createState() => _MedicineListTileWidgetState(title, medicineUrl);

  MedicineListTileWidget(this.title, this.medicineUrl);
}

class _MedicineListTileWidgetState extends State<MedicineListTileWidget> {
  _MedicineListTileWidgetState(this.title, this.medicineUrl);

  final String title;
  final String medicineUrl;

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
                      color: AppColors.prussianBlue,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 26),
                      ),
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
          MedicineDetailsScreen(title, medicineUrl),
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
