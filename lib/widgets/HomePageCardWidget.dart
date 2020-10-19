import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inz_pills/Utils/colors.dart';

class HomePageCardWidget extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  HomePageCardWidget(this.title, this.color, this.icon);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: EdgeInsets.all(12),
      onPressed: () {
        Navigator.pushNamed(context, '/second');
      },
      style: NeumorphicStyle(
        color: Colors.white,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          children: [
            NeumorphicIcon(
              icon,
              size: 70,
              style: NeumorphicStyle(
                depth: 4,
                color: color,
              ),
            ),
            Spacer(),
            NeumorphicText(
              title,
              style: NeumorphicStyle(
                color: AppColors.prussianBlue,
              ),
              textStyle: NeumorphicTextStyle(
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
