import 'package:evently/utils/app_Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseDateOrTime extends StatelessWidget {
  String iconName;
  String eventDateOrTime;
  Function onChooseDateOrTimeClicked;
  String chooseDateOrTime;

  ChooseDateOrTime({
    super.key,
    required this.iconName,
    required this.eventDateOrTime,
    required this.onChooseDateOrTimeClicked,
    required this.chooseDateOrTime,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Image.asset(iconName,),
SizedBox(width: width*0.02,),
        Text(eventDateOrTime, style: AppStyles.semi16black),
Spacer(),
        TextButton(onPressed: () {onChooseDateOrTimeClicked();;}, child: Text(chooseDateOrTime,style:AppStyles.semi16Primary,)),
      ],
    );
  }
}
