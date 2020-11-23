import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:inz_pills/Models/Appointment.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Widgets/AppointmentsListTileWidget.dart';
import 'package:provider/provider.dart';

class AppointmentsList extends StatefulWidget {
  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  @override
  Widget build(BuildContext context) {
    final userAppointments = Provider.of<List<Appointment>>(context);
    if (userAppointments != null) {
      userAppointments.sort((a, b) => a.date.compareTo(b.date));
    }
    return userAppointments == null
        ? Loading()
        : ListView.builder(
            itemCount: userAppointments.length < 5 ? userAppointments.length : 5,
            itemBuilder: (context, index) {
              return FutureBuilder(
                  future: getAddress(userAppointments[index].location),
                  builder: (context, text) {
                    if (text.hasData) {
                      Address address = text.data;
                      return AppointmentsListTileWidget(userAppointments[index], address);
                    } else {
                      return Loading();
                    }
                  });
            });
  }

  Future<Address> getAddress(GeoPoint geoPoint) async {
    final coordinates = new Coordinates(geoPoint.latitude, geoPoint.longitude);
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }
}

// return Container(
// child: Column(
// children: [
// Text(userAppointments[index].getDateTimeString()),
// Text(userAppointments[index].userId),
// Text(userAppointments[index].doctorName),
// Text(userAppointments[index].doctorSpecialisation),
// Text(address.addressLine),
// FlatButton(
// onPressed: () async {
// String googleUrl =
//     'https://www.google.com/maps/search/?api=1&query=${userAppointments[index].location.latitude},${userAppointments[index].location.longitude}';
// if (await canLaunch(googleUrl)) {
// await launch(googleUrl);
// } else {
// throw 'Could not open the map.';
// }
// },
// child: Text('Click here to open in Google Maps'))
// ],
// ));
