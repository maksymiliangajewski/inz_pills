import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:provider/provider.dart';

class UserEditPanel extends StatefulWidget {
  @override
  _UserEditPanelState createState() => _UserEditPanelState();
}

class _UserEditPanelState extends State<UserEditPanel> {
  final _formKey = GlobalKey<FormState>();
  List<String> sexes = ['female', 'male', 'other'];
  DateTime selectedDate = DateTime.now();

  String _currentName;
  String _currentSurname;
  DateTime _currentBirthDate;
  String _currentSex;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
        child: StreamBuilder<MyUser>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MyUser userData = snapshot.data;
                _currentBirthDate = userData.birthDate.toDate();
                return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(StringAssets.updateUserData),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration(StringAssets.name),
                          validator: (val) =>
                              val.isEmpty ? StringAssets.pleaseEnterName : null,
                          onChanged: (val) =>
                              setState(() => _currentName = val),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: userData.surname,
                          decoration: textInputDecoration(StringAssets.surname),
                          validator: (val) => val.isEmpty
                              ? StringAssets.pleaseEnterSurname
                              : null,
                          onChanged: (val) =>
                              setState(() => _currentSurname = val),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                                onPressed: () => _selectDate(context),
                                child: Text("Kliknij, aby wybrać datę urodzenia"),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField(
                            value: _currentSex ?? userData.sex,
                            decoration: textInputDecoration(StringAssets.sex),
                            items: sexes.map((String sex) {
                              return DropdownMenuItem<String>(
                                  value: sex, child: Text('$sex'));
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _currentSex = value);
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              color: AppColors.prussianBlue,
                              child: Text(
                                StringAssets.update,
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await DatabaseService(uid: user.uid)
                                      .updateUserData(
                                    _currentName ?? userData.name,
                                    _currentSurname ?? userData.surname,
                                    Timestamp.fromDate(selectedDate) ?? userData.birthDate,
                                    _currentSex ?? userData.sex,
                                  );
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            RaisedButton(
                                color: AppColors.imperialRed,
                                child: Text(StringAssets.cancel,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () => Navigator.pop(context))
                          ],
                        ),
                      ],
                    ));
              } else {
                return Loading();
              }
            }),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _currentBirthDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if(pickedDate != null && pickedDate != _currentBirthDate) {
      setState(() {
        selectedDate = pickedDate;
        _currentBirthDate = pickedDate;
      });
    }
  }
}
