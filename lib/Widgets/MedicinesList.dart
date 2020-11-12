import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Medicine.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:provider/provider.dart';
import 'package:inz_pills/Widgets/MedicinesListTileWidget.dart';

class MedicinesList extends StatefulWidget {
  @override
  _MedicinesListState createState() => _MedicinesListState();
}

class _MedicinesListState extends State<MedicinesList> {
  @override
  Widget build(BuildContext context) {
    final userMedicines = Provider.of<List<Medicine>>(context);
    return userMedicines == null
        ? Loading()
        : ListView.builder(
            itemCount: userMedicines.length,
            itemBuilder: (context, index) {
              return MedicineListTileWidget(userMedicines[index].name, userMedicines[index].link);
            });
  }
}
