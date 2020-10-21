import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inz_pills/Utils/colors.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.prussianBlue,
      padding: EdgeInsets.only(top: 60, left: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(),
              SizedBox(width: 10),
              Text('Username', style: TextStyle(
                color: AppColors.honeydew,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(children: [
                    Icon(FontAwesomeIcons.addressBook, color: AppColors.honeydew,),
                    SizedBox(width: 10),
                    Text('Menu 1',
                    style: TextStyle(color: AppColors.honeydew,
                    ),)
                  ],),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(children: [
                    Icon(FontAwesomeIcons.baby, color: AppColors.honeydew,),
                    SizedBox(width: 10),
                    Text('Menu 2',
                        style: TextStyle(color: AppColors.honeydew,
                        ))
                  ],),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(children: [
                    Icon(FontAwesomeIcons.facebook, color: AppColors.honeydew,),
                    SizedBox(width: 10),
                    Text('Menu 3',
                        style: TextStyle(color: AppColors.honeydew,
                        ))
                  ],),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Row(children: [
                    Icon(FontAwesomeIcons.ravelry, color: AppColors.honeydew,),
                    SizedBox(width: 10),
                    Text('Menu 4',
                        style: TextStyle(color: AppColors.honeydew,
                        ))
                  ],),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.cog, color: AppColors.honeydew,),
              SizedBox(width: 10),
              Text('Settings',
                style: TextStyle(
                  color: AppColors.honeydew,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 1,
                height: 20,
                color: AppColors.honeydew,
              ),
              SizedBox(width: 10),
              Text('Log out',
                style: TextStyle(
                    color: AppColors.honeydew,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
