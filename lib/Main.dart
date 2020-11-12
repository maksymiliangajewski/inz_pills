import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inz_pills/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'Wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InzApp());
}

class InzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(textTheme: GoogleFonts.alataTextTheme()),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
