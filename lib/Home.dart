import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/MyUser.dart';
import 'Pages/DrawerScreen.dart';
import 'Pages/HomeScreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen(uid: user.uid)],
      ),
    );
  }
}
