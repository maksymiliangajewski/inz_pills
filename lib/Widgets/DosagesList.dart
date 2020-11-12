import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Widgets/HomeScreenDosagesListTileWidget.dart';
import 'package:provider/provider.dart';

class DosagesList extends StatefulWidget {
  @override
  _DosagesListState createState() => _DosagesListState();
}

class _DosagesListState extends State<DosagesList> {
  @override
  Widget build(BuildContext context) {
    final userDosages = Provider.of<List<Dosage>>(context);
    return userDosages == null
        ? Loading()
        : ListView.builder(
            itemCount: userDosages.length < 5 ? userDosages.length : 5,
            itemBuilder: (context, index) {
              return HomeScreenDosagesListTileWidget(dosage: userDosages[index]);
            });
  }
}
