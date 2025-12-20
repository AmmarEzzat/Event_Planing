import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_Colors.dart';

class AddEvent extends StatefulWidget {
  static const String route = "AddEvent";

   AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
 int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String>imageSelectedNameList=[

      AppAssets.EventSport1,
      AppAssets.EventBirthday1,
      AppAssets.EventMeeting1,
      AppAssets.EventGaming1,
      AppAssets.EventWorkshop,
      AppAssets.EventBookclub1,
      AppAssets.EventExhibition1,
      AppAssets.EventHoliday1,
      AppAssets.EventEating1,


    ];
    // List<String>iconSelectedNameList=[
    //
    //   AppAssets.iconsBike,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //   AppAssets.iconsCake,
    //
    //
    // ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageprovider = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createevent, style: AppStyles.bold20Primary),
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.009,
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(imageSelectedNameList[selectedIndex]
                   ,height: height*0.24,
              ),
            ),
          ),

          Container(


            height: height * 00.08,
            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return InkWell(

                onTap: (){

                  selectedIndex=index;
                  setState(() {

                  });
                },
                child: TabEventWidget(

                    isSelected:selectedIndex==index ,

                    eventName: eventsNameList[index],
                    backgroundColor: AppColors.primaryLight,
                borderColor: AppColors.primaryLight,
                    textSelectedStyle: AppStyles.semi16white,
                    textUnSelectedStyle: AppStyles.semi16Primary,


                  ),
              );
              },
              itemCount: eventsNameList.length,
            ),
          ),
        ],
      ),
    );
  }
}
