import 'package:flutter/material.dart';
import 'Pages/DrawerScreen.dart';
import 'Pages/HomeScreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}
