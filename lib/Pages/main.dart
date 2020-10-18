import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/colors.dart';

void main() => runApp(InzApp());

class InzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.honeydew,
      appBar: AppBar(
        backgroundColor: AppColors.prussianBlue,
        title: Text(
          'Inzynierka App',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: AppColors.honeydew),
        ),
        centerTitle: true,
        elevation: 5.0,
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.ellipsis_vertical),
              color: AppColors.honeydew,
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: AppColors.honeydew,
              onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Main screen!',
            ),
          ],
        ),
      ),
    );
  }
}
