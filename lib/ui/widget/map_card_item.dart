import 'package:evently/model/event.dart';
import 'package:evently/utils/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MapCardItem extends StatelessWidget {
  final Event eventModel;
  final Function(double,double)onPress;

  const MapCardItem({super.key, required this.eventModel,required this.onPress});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){onPress
    (eventModel.lat,eventModel.long);
    },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,

          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 138 / 78,

              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),

                child: Image.asset(eventModel.image, height: double.infinity),

              ),
            ),

            SizedBox(width: 8,),

            Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(eventModel.title,style: Theme.of(context).textTheme.titleLarge!.copyWith(

                color: AppColors.primaryLight

              ),
                  maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                  const Spacer(),

                  Row(

                    children: [

                      Icon(Icons.location_on_outlined,color: AppColors.blackColor,),

                    Expanded(child: Text("${eventModel.lat.floor()}:${eventModel.long.floor()}",maxLines: 1,))  ,
                    ],

                  ),
                  SizedBox(height: height*0.01,),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
