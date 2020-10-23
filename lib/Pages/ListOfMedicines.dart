import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Medicine.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:inz_pills/Utils/MedicineWebScraper.dart' as scraper;

class ListOfMedicines extends StatefulWidget {
  final String pageTitle;
  @override
  _ListOfMedicinesState createState() => _ListOfMedicinesState(pageTitle);

  ListOfMedicines(this.pageTitle);
}

class _ListOfMedicinesState extends State<ListOfMedicines> {
  _ListOfMedicinesState(this.pageTitle);

  final String pageTitle;
  bool _isInAsyncCall = false;
  String medicineInfo = '';
  Medicine medicine;

  // var users = new List<User>();
  //
  // _getUsers() {
  //   API.getUsers().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       users = list.map((model) => User.fromJson(model)).toList();
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _isInAsyncCall = true;
    getMedicine();
    // _getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getMedicine() async {
    medicine = await scraper.getMedicine();
    setState(() {
      medicineInfo = medicine.printData();
      _isInAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.honeydew,
        ),
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
                    pageTitle,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: ModalProgressHUD(
                  inAsyncCall: _isInAsyncCall,
                  progressIndicator: Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator()),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(medicineInfo),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// Expanded szedł po SizedBoxie(40)
// Expanded(
// child: ListView.builder(
// itemCount: users.length,
// itemBuilder: (context, index) {
// return ListTile(
// leading: Icon(Icons.email),
// title: Text(users[index].name),
// trailing: IconButton(
// icon: Icon(Icons.add),
// onPressed: () => print('pressed icon'),
// ),
// );
// },
// ),
// )
