import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Widgets/DosagesList.dart';
import 'package:provider/provider.dart';

class DosagesListScreen extends StatefulWidget {
  @override
  _DosagesListScreenState createState() => _DosagesListScreenState();
}

class _DosagesListScreenState extends State<DosagesListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Dosage>>.value(
      value: DatabaseService(uid: user.uid).userDosages,
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
                      'List of your dosages',
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
                child: DosagesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
