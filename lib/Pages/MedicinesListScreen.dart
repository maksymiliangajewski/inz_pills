import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Medicine.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:inz_pills/Widgets/MedicinesList.dart';
import 'package:provider/provider.dart';

class MedicinesListScreen extends StatefulWidget {
  @override
  _MedicinesListScreenState createState() => _MedicinesListScreenState();
}

class _MedicinesListScreenState extends State<MedicinesListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<List<Medicine>>.value(
      value: DatabaseService(uid: user.uid).userMedicines,
      child: Material(
        child: Container(
          decoration: BoxDecoration(color: AppColors.honeydew),
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      StringAssets.yourMedicines,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: MedicinesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
