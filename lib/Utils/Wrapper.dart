import 'package:flutter/material.dart';
import 'package:inz_pills/Authenticate/Authenticate.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Pages/Home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
