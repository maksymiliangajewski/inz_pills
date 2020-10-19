import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inz_pills/Utils/colors.dart';
import 'package:inz_pills/widgets/DrawerWidget.dart';
import 'package:inz_pills/widgets/HomePageCardWidget.dart';

void main() => runApp(InzApp());

class InzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Inzynierka App',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: AppColors.honeydew,
        lightSource: LightSource.topLeft,
        depth: 5,
      ),
      darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 6),
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
      drawer: DrawerWidget(),
      appBar: NeumorphicAppBar(
        buttonStyle: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 3,
            lightSource: LightSource.topLeft),
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
            children: [
              HomePageCardWidget('Your pills', AppColors.powderBlue,
                  CupertinoIcons.arrowshape_turn_up_right_fill),
              HomePageCardWidget('Find medicines', AppColors.imperialRed,
                  CupertinoIcons.square_stack_3d_down_right),
              HomePageCardWidget('Create a reminder', AppColors.prussianBlue,
                  CupertinoIcons.plus_circle_fill),
            ],
          ),
        ),
      ),
    );
  }
}
