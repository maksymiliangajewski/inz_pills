import 'package:flutter/material.dart';
import 'package:inz_pills/Services/Auth.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Utils/StringAssets.dart';
import 'package:inz_pills/Widgets/UserEditPanel.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.powderBlue,
              title: Text(
                StringAssets.register,
                style: TextStyle(color: AppColors.prussianBlue),
              ),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text(
                      StringAssets.signIn,
                      style: TextStyle(color: AppColors.prussianBlue),
                    ))
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.powderBlue, AppColors.caladonBlue]),
                color: AppColors.honeydew,
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: textInputDecoration(StringAssets.email),
                          validator: (val) =>
                              val.isEmpty ? StringAssets.enterEmail : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        TextFormField(
                          decoration:
                              textInputDecoration(StringAssets.password),
                          validator: (val) => val.length < 6
                              ? StringAssets.enterLongerPassword
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(33.0)),
                              color: AppColors.prussianBlue,
                              child: Text(
                                StringAssets.register,
                                style: TextStyle(color: AppColors.honeydew, fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = StringAssets
                                          .pleaseSupplyValidCredentials;
                                      loading = false;
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserEditPanel()));
                                  }
                                }
                              }),
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
