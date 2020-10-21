import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/colors.dart';
import 'package:inz_pills/widgets/HomePageButton.dart';
import 'package:inz_pills/widgets/PillsHomeScreenWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 300),
      color: AppColors.honeydew,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isDrawerOpen
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            scaleFactor = 1;
                            isDrawerOpen = false;
                          });
                        })
                    : IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xOffset = 230;
                            yOffset = 150;
                            scaleFactor = 0.6;
                            isDrawerOpen = true;
                          });
                        }),
                Text('Inzynierka App'),
                CircleAvatar()
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.add),
                Text('Create new reminder'),
                Icon(Icons.settings)
              ],
            ),
          ),
          Container(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomePageButton('Pills', 'drugs.png'),
                HomePageButton('Appointments', 'doctor.png'),
                HomePageButton('Search', 'magnifying-glass.png'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text(
              'Your upcoming pills:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                PillsHomeScreenWidget(),
                PillsHomeScreenWidget(),
                PillsHomeScreenWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
