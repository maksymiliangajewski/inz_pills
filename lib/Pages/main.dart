import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Pages/drawerScreen.dart';
import 'package:inz_pills/Pages/homeScreen.dart';

void main() => runApp(MaterialApp(home: InzApp()));

class InzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}

// return MaterialApp(
// debugShowCheckedModeBanner: false,
// title: 'Inzynierka App',
// themeMode: ThemeMode.light,
// theme: ThemeData(primaryColor: AppColors.honeydew, fontFamily: 'Roboto'),
// home: HomePage(),
// routes: {
// '/second': (context) => Screen1(),
// },
// );
