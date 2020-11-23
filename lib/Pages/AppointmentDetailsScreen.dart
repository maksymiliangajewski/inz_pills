import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:inz_pills/Models/Appointment.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final Appointment appointment;
  final Address address;

  AppointmentDetailsScreen(this.appointment, this.address);

  @override
  _AppointmentDetailsScreenState createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.caladonBlue,
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
                      color: AppColors.honeydew,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height,
                            margin: EdgeInsets.only(top: size.height * 0.13),
                            decoration: BoxDecoration(
                              color: AppColors.honeydew,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: size.height * 0.07),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text('Visit details',
                                            style:
                                                TextStyle(color: AppColors.honeydew, fontSize: 38)),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lekarz prowadzący:',
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.appointment.doctorName,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        'Specjalizacja:',
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.appointment.doctorSpecialisation,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        'Godzina i data wizyty:',
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.appointment.getDateTimeString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        'Lokalizacja:',
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      Text(
                                        widget.address.addressLine,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 30),
                                      RaisedButton(
                                        color: AppColors.prussianBlue,
                                        onPressed: () async {
                                          String googleUrl =
                                              'https://www.google.com/maps/search/?api=1&query=${widget.appointment.location.latitude},${widget.appointment.location.longitude}';
                                          if (await canLaunch(googleUrl)) {
                                            await launch(googleUrl);
                                          } else {
                                            throw 'Could not open the map.';
                                          }
                                        },
                                        child: Text(
                                          'Open location in Google Maps',
                                          style: TextStyle(color: AppColors.honeydew),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
