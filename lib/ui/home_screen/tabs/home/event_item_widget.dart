import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.31,
      margin: EdgeInsets.symmetric(

        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: BoxBorder.all(color: AppColors.primaryLight, width: 2),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(AppAssets.EventBirthday1),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(height*0.002),
            margin: EdgeInsets.all(width*0.03),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text("21", style: AppStyles.bold20Primary),
                Text("Nov ", style: AppStyles.bold20Primary),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
            margin: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
            decoration: BoxDecoration(
              
              borderRadius: 
                BorderRadius.circular(20),
              border: Border.all(width: 8),
              color: AppColors.whiteColor
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text("This is a Birthday Party ",style: AppStyles.bold14black,),
Image.asset(AppAssets.iconsHeart,color: AppColors.primaryLight,)
                
              ],
              
            ),
          )
        ],
      ),
    );
  }
}
