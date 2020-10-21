import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/User.dart';
import 'package:inz_pills/Utils/API.dart';
import 'package:inz_pills/Utils/Colors.dart';

class Screen1 extends StatefulWidget {
  final String pageTitle;
  @override
  _Screen1State createState() => _Screen1State(pageTitle);

  Screen1(this.pageTitle);
}

class _Screen1State extends State<Screen1> {
  _Screen1State(this.pageTitle);

  final String pageTitle;
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  void dispose() {
    super.dispose();
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
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.email),
                    title: Text(users[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => print('pressed icon'),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
