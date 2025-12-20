import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? backgroundColor;
  Widget? preffixIcobbutton;
  TextStyle? stylebutton;
  Color? colorborder;
  String text;
  Function onbuttonClicked;

  CustomElevatedButton({
    super.key,
    this.backgroundColor,
    this.preffixIcobbutton,
    required this.text,
    this.stylebutton,
    this.colorborder,
    required this.onbuttonClicked
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryLight,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(25),
          side: BorderSide(
            width: 2,
            color: colorborder ?? AppColors.primaryLight,
          ),
        ),
      ),
      onPressed: () {
        onbuttonClicked();
        },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          preffixIcobbutton ?? SizedBox(),

          Text(text, style: stylebutton ?? AppStyles.semi20white),
        ],
      ),
    );
  }
}
