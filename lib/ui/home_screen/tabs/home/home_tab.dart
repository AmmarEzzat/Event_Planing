import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:evently/ui/home_screen/tabs/home/tab_event_widget.dart';

import 'package:evently/utils/app_Colors.dart';
import 'package:evently/utils/app_Styles.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);

    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents();
    }
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
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

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcomeBack,
                  style: AppStyles.semi16white,
                ),

                Text("AmmarEzzat", style: AppStyles.bold24white),
                SizedBox(height: height * 0.01),
              ],
            ),
            Row(
              children: [
                Icon(Icons.sunny, color: AppColors.whiteColor),
                SizedBox(width: width * 0.02),
                Container(
                  margin: EdgeInsets.only(right: width * 0.01),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.01,
                    vertical: width * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.en,
                    style: AppStyles.bold14primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.12,

            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssets.iconsMapPin,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(width: width * 0.01),
                      Text("Cairo , Egypt", style: AppStyles.medium14white),
                    ],
                  ),

                  SizedBox(height: height * 0.02),
                  DefaultTabController(
                    length: eventsNameList.length,
                    child: TabBar(
                      onTap: (index) {
                        eventListProvider.changeSelectedEvent(index);
                      },
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,

                      dividerColor: AppColors.transparentColor,

                      tabs: eventsNameList.map((eventName) {
                        return TabEventWidget(
                          backgroundColor: AppColors.whiteColor,
                          textSelectedStyle: AppStyles.semi16Primary,
                          textUnSelectedStyle: AppStyles.semi16white,
                          isSelected:
                              eventListProvider.Selectedindex ==
                              eventsNameList.indexOf(eventName),
                          eventName: eventName,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: eventListProvider.filterEventList.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.noeventsfound),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: ListView.builder(
                      itemCount: eventListProvider.filterEventList.length,
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          event: eventListProvider.filterEventList[index],
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
