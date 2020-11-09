import 'package:flutter/material.dart';

import 'DrawerScreen.dart';
import 'HomeScreen.dart';

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
