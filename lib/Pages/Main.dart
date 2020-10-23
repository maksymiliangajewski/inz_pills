import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Pages/DrawerScreen.dart';
import 'package:inz_pills/Pages/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      home: InzApp(),
      theme: ThemeData(textTheme: GoogleFonts.alataTextTheme()),
      debugShowCheckedModeBanner: false,
    ));

class InzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}
