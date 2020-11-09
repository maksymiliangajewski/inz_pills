import 'package:flutter/material.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Widgets/PillsHomeScreenWidget.dart';
import 'package:provider/provider.dart';
import 'package:inz_pills/Models/Dosage.dart';

class HomeScreenDosagesList extends StatefulWidget {
  @override
  _HomeScreenDosagesListState createState() => _HomeScreenDosagesListState();
}

class _HomeScreenDosagesListState extends State<HomeScreenDosagesList> {
  @override
  Widget build(BuildContext context) {
    final userDosages = Provider.of<List<Dosage>>(context);
    return userDosages == null
        ? Loading()
        : ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return PillsHomeScreenWidget(dosage: userDosages[index]);
            });
  }
}
