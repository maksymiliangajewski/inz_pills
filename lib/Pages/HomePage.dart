import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/colors.dart';
import 'package:inz_pills/widgets/DrawerWidget.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Inzynierka App',
            style: TextStyle(
                fontSize: 25,
                color: AppColors.prussianBlue,
                fontFamily: 'Roboto'),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: [],
          ),
        ),
      ),
    );
  }
}
