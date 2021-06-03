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
    Map<String, Medicine> uniqueUserMedicines = {};
    for (Medicine medicine in userMedicines) {
      uniqueUserMedicines[medicine.name] = medicine;
    }
    var uniqueUserMedicinesList = uniqueUserMedicines.values.toList();
    return uniqueUserMedicinesList == null
        ? Loading()
        : ListView.builder(
            itemCount: uniqueUserMedicinesList.length,
            itemBuilder: (context, index) {
              return MedicineListTileWidget(uniqueUserMedicinesList[index].name,
                  uniqueUserMedicinesList[index].link);
            });
  }
}
