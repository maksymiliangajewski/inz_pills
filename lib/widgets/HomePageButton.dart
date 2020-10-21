import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/imageAssets.dart';

class HomePageButton extends StatelessWidget {
  final String title;
  final String icon;

  HomePageButton(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20)),
            child: Material(
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'images/$icon',
                  width: MediaQuery.of(context).size.width*0.1,
                ),
              ),
            ),
          ),
          Text('$title')
        ],
      ),
    );
  }
}
