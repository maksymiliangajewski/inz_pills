import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Dosage.dart';

class DosageTile extends StatelessWidget {
  final Dosage dosage;

  DosageTile({this.dosage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          title: Text(dosage.userId),
          subtitle: Text(dosage.medicine),
        ),
      ),
    );
  }
}
