import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String _currentName;
  String _currentSurname;
  int _currentAge;
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
                return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(StringAssets.updateUserData),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration(StringAssets.name),
                          validator: (val) => val.isEmpty ? StringAssets.pleaseEnterName : null,
                          onChanged: (val) => setState(() => _currentName = val),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: userData.surname,
                          decoration: textInputDecoration(StringAssets.surname),
                          validator: (val) => val.isEmpty ? StringAssets.pleaseEnterSurname : null,
                          onChanged: (val) => setState(() => _currentSurname = val),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: userData.age.toString(),
                          decoration: textInputDecoration(StringAssets.age),
                          validator: (val) => val.isEmpty ? StringAssets.pleaseEnterAge : null,
                          onChanged: (val) => setState(() => _currentAge = int.parse(val)),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField(
                            value: _currentSex ?? userData.sex,
                            decoration: textInputDecoration(StringAssets.sex),
                            items: sexes.map((String sex) {
                              return DropdownMenuItem<String>(value: sex, child: Text('$sex'));
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
                                  await DatabaseService(uid: user.uid).updateUserData(
                                    _currentName ?? userData.name,
                                    _currentSurname ?? userData.surname,
                                    _currentAge ?? userData.age,
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
}
