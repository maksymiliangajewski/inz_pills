import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inz_pills/Utils/colors.dart';

class Screen1 extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
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
      child: Neumorphic(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeumorphicText(
            'Henlo',
            textStyle: NeumorphicTextStyle(
              fontSize: 20,
            ),
            style: NeumorphicStyle(
              color: AppColors.prussianBlue
            ),
          ),
        ),
      ),
    ),
  );
}
}
