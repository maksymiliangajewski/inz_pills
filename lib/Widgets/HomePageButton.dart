import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Pages/AppointmentsListScreen.dart';
import 'package:inz_pills/Pages/DosagesListScreen.dart';
import 'package:inz_pills/Pages/MedicinesListScreen.dart';
import 'package:inz_pills/Pages/RemindersListScreen.dart';
import 'package:inz_pills/Utils/Colors.dart';

class HomePageButton extends StatelessWidget {
  final String title;
  final String icon;

  HomePageButton(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 30, right: 30, top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
              onLongPress: () => print('long pressed'),
              child: Image.asset(
                'images/$icon',
                width: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
          ),
          Text(
            '$title',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        switch (title) {
          case 'Medication':
            return MedicinesListScreen();
          case 'Dosages':
            return DosagesListScreen();
          case 'Appointments':
            return AppointmentsListScreen();
          case 'Reminders':
            return RemindersListScreen();
          default:
            return null;
        }
      },
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
