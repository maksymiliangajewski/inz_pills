import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Appointment.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Widgets/AppointmentsList.dart';
import 'package:provider/provider.dart';

class AppointmentsListScreen extends StatefulWidget {
  @override
  _AppointmentsListScreenState createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Appointment>>.value(
      value: DatabaseService(uid: user.uid).userAppointments,
      child: Material(
        child: Container(
          decoration: BoxDecoration(color: AppColors.honeydew),
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
                      'List of your appointments',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Appointments notifications will be shown 2 hours before the visit.',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: AppointmentsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
