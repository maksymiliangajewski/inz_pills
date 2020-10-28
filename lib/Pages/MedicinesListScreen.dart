import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Widgets/PillsDetailsScreenWidget.dart';

Map<String, String> medicines = {
  'Polopiryna® MAX':
      'http://bazalekow.leksykon.com.pl/informacja-o-lekach-Polopiryna%C2%AE-MAX-4429324.html',
  'Controloc Control®':
      'http://bazalekow.leksykon.com.pl/informacja-o-lekach-Controloc-Control%C2%AE-10278968.html',
  'Nasonex®':
      'http://bazalekow.leksykon.com.pl/informacja-o-lekach-Nasonex%C2%AE-2123.html',
  'Loxon Max':
      'http://bazalekow.leksykon.com.pl/informacja-o-lekach-Loxon-Max-3209406.html',
  'Dexilant':
      'http://bazalekow.leksykon.com.pl/informacja-o-leku-Dexilant-26404021.html',
  'Aerius':
      'http://bazalekow.leksykon.com.pl/informacja-o-lekach-Aerius-61.html'
};
List<String> medicinesNames = medicines.keys.toList();
List<String> medicinesUrls = medicines.values.toList();

class MedicinesListScreen extends StatefulWidget {
  @override
  _MedicinesListScreenState createState() => _MedicinesListScreenState();
}

class _MedicinesListScreenState extends State<MedicinesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
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
                    'List of your medicines',
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
              child: ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (PillsDetailsScreenWidget(
                        medicinesNames[index], medicinesUrls[index]));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
