import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:inz_pills/Utils/Loading.dart';
import 'package:inz_pills/Widgets/HomeScreenDosagesListTileWidget.dart';
import 'package:provider/provider.dart';
import 'package:inz_pills/Models/Dosage.dart';

class HomeScreenDosagesList extends StatefulWidget {
  @override
  _HomeScreenDosagesListState createState() => _HomeScreenDosagesListState();
}

class _HomeScreenDosagesListState extends State<HomeScreenDosagesList> {
  @override
  Widget build(BuildContext context) {
    final userDosages = Provider.of<List<Dosage>>(context);
    if (userDosages != null) {
      userDosages.sort((a, b) => a.takeTime.compareTo(b.takeTime));
    }
    if (!areUpcomingDosages()) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.smileBeam,
                color: AppColors.prussianBlue,
                size: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'You have no upcoming dosages.',
                  style: TextStyle(fontSize: 20, color: AppColors.prussianBlue),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ((userDosages != null))
          ? ListView.builder(
              itemCount: userDosages.length < 5 ? userDosages.length : 5,
              itemBuilder: (context, index) {
                if (DateTime.fromMillisecondsSinceEpoch(userDosages[index].takeTime.seconds * 1000)
                    .toLocal()
                    .isAfter(DateTime.now())) {
                  return HomeScreenDosagesListTileWidget(dosage: userDosages[index]);
                } else {
                  return Container();
                }
              })
          : Loading();
    }
  }

  bool areUpcomingDosages() {
    bool anyUpcomingDosage = false;
    List<Dosage> dosages = Provider.of<List<Dosage>>(context);
    if (dosages != null) {
      dosages.forEach((element) {
        if (DateTime.fromMillisecondsSinceEpoch(element.takeTime.seconds * 1000)
            .toLocal()
            .isAfter(DateTime.now())) {
          anyUpcomingDosage = true;
        }
      });
    }
    return anyUpcomingDosage;
  }
}
