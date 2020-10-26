import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inz_pills/Models/Medicine.dart';
import 'package:inz_pills/Utils/Colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:inz_pills/Utils/MedicineWebScraper.dart' as scraper;

class MedicineDetailsScreen extends StatefulWidget {
  final String medicineName;
  final String medicineUrl;

  @override
  _MedicineDetailsScreenState createState() =>
      _MedicineDetailsScreenState(medicineName, medicineUrl);

  MedicineDetailsScreen(this.medicineName, this.medicineUrl);
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  _MedicineDetailsScreenState(this.medicineName, this.medicineUrl);

  final String medicineName;
  final String medicineUrl;
  bool _isInAsyncCall = false;
  String medicineInfo = '';
  Medicine medicine;

  @override
  void initState() {
    super.initState();
    _isInAsyncCall = true;
    _getMedicine(medicineUrl);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getMedicine(String medicineUrl) async {
    medicine = await scraper.getMedicine(medicineUrl);
    setState(() {
      medicineInfo = medicine.printData();
      _isInAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.prussianBlue,
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
              child: ModalProgressHUD(
                  color: Colors.transparent,
                  inAsyncCall: _isInAsyncCall,
                  progressIndicator: Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator()),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height,
                          child: Stack(
                            children: [
                              Container(
                                height: size.height,
                                margin: EdgeInsets.only(top: size.height * 0.2),
                                decoration: BoxDecoration(
                                  color: AppColors.honeydew,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Details for:',
                                      style: TextStyle(
                                          color: AppColors.honeydew,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: size.height * 0.07),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(medicineName,
                                            style: TextStyle(
                                                color: AppColors.honeydew,
                                                fontSize: 38)),
                                      ),
                                    ),
                                    Expanded(
                                        child: _isInAsyncCall
                                            ? SizedBox()
                                            : ListView(
                                                padding:
                                                    EdgeInsets.only(top: 0),
                                                children: [
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Indication',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.indication)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Dosage',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.dosage)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Comments',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.comments)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Contraindications',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine
                                                          .contraindications)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Warnings',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.warnings)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Interactions',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(
                                                          medicine.interactions)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Pregnancy',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.pregnancy)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Side effects',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.sideEffects)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Overdose',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.overdose)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Action',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.action)
                                                    ],
                                                  ),
                                                  ExpansionCard(
                                                    title: Text(
                                                      'Composition',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .prussianBlue,
                                                          fontSize: 16),
                                                    ),
                                                    children: [
                                                      Text(medicine.composition)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.2,
                                                  )
                                                ],
                                              ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}