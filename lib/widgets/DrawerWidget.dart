import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/colors.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 0.0),
                    colors: <Color>[
                  AppColors.prussianBlue,
                  AppColors.honeydew,
                ])),
            child: Container(
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'images/flutter-logo.png',
                        width: 75,
                        height: 75,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'user',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomListTile('Profile', Icons.person, () => {}),
          CustomListTile('Settings', Icons.settings, () => {}),
          CustomListTile('Log out', Icons.lock, () => {}),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String title;
  Function onTap;

  CustomListTile(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        splashColor: AppColors.powderBlue,
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: AppColors.prussianBlue,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 15),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.prussianBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
