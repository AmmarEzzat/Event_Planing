import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_Colors.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      child: Scaffold(
resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Column(

          children: [

            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField(borderColor: AppColors.primaryLight,


                hintText: AppLocalizations.of(context)!.searchforevent,
                hintStyle: AppStyles.bold14primary,
style: AppStyles.bold16Primary,

prefixIcon: Icon(Icons.search,color: AppColors.primaryLight,),


              ),
            ),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:   width * 0.04,),
                child: ListView.builder(itemCount: 10,
                  itemBuilder: (context, index) {
                    return EventItemWidget();
                  },
                ),
              ),
            ),
          ],

        ),


      ),
    );
  }
}
