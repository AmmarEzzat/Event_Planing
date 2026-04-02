
import 'package:evently/model/event.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemWidget extends StatelessWidget {
  Event event;

  EventItemWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.31,
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: BoxBorder.all(color: AppColors.primaryLight, width: 2),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.image),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(height * 0.002),
            margin: EdgeInsets.all(width * 0.03),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  event.dateTime.day.toString(),
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime),
                  style: AppStyles.bold20Primary,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            margin: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.whiteColor, width: 2),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: AppStyles.bold14black,

                  ),
                ),
                Image.asset(
                  AppAssets.iconsHeart,
                  color: AppColors.primaryLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}