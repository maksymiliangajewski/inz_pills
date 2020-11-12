import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inz_pills/Utils/Colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.honeydew,
      child: Center(
        child: SpinKitDoubleBounce(
          color: AppColors.prussianBlue,
          size: 50,
        ),
      ),
    );
  }
}
