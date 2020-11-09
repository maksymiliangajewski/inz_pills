import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Widgets/HomeScreenDosagesList.dart';
import 'package:inz_pills/widgets/HomePageButton.dart';
import 'package:provider/provider.dart';

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
    return StreamProvider<List<Dosage>>.value(
      value: DatabaseService().dosages,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0),
          color: AppColors.honeydew,
        ),
        child: GestureDetector(
          onTap: () {
            if (isDrawerOpen) {
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              });
            }
          },
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
                    Text(
                      'Inzynierka App',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.add),
                    Text('Create new reminder'),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomePageButton('Medication', 'drugs.png'),
                    HomePageButton('Dosages', 'doctor.png'),
                    HomePageButton('Search', 'magnifying-glass.png'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Your upcoming pills',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(child: HomeScreenDosagesList())
            ],
          ),
        ),
      ),
    );
  }
}
