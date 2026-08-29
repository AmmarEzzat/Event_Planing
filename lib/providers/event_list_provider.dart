import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../utils/app_Colors.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventList = [];
  List<Event> favoriteEventList = [];

  List<String> eventsNameList =[
  ];

  void getEventNameList(BuildContext context) {
    eventsNameList = [  "All",
      "Sport",
      "Birthday",
      "Meeting",
      "Gaming",
      "Workshop",
      "BookClub",
      "Exhibition",
      "Holiday",
      "Eating",
    ];
  }


  int Selectedindex = 0;

  void getAllEvents( String uId ) async {
    QuerySnapshot<Event> querysnapshot =
    await FirebaseUtils.getEventCollection(uId).get();

    eventsList = querysnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    //sorting
    eventsList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });

    filterEventList = eventsList;

    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    QuerySnapshot<Event> querysnapshot =
    await FirebaseUtils.getEventCollection(uId).get();

    eventsList = querysnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    filterEventList = eventsList.where((event) {
      return event.eventName == eventsNameList[Selectedindex];
    }).toList();

    notifyListeners();
  }

  void updateIsFavoriteEvent(Event event,String uId) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({"isfavorite": !event.isFavorite}).then((value){

      Fluttertoast.showToast(msg: 'event updated successfully',
          backgroundColor: AppColors.whiteColor,
          textColor: AppColors.blackColor,
          gravity: ToastGravity.BOTTOM,
          fontSize:15);

    })
        .timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          Fluttertoast.showToast(msg: 'event updated successfully',
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.blackColor,
              gravity: ToastGravity.BOTTOM,
              fontSize:15);
        }
    );
    Selectedindex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
    getFavoriteEvents(uId);
  }

  void getFavoriteEvents(String uId) async {
    var querysnapshot = await FirebaseUtils.getEventCollection(uId)
        .orderBy("datetime", descending: false)
        .where("isfavorite", isEqualTo: true)
        .get();
    favoriteEventList = querysnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedEvent(int newSelectedIndex,String uId) {
    Selectedindex = newSelectedIndex;

    if (Selectedindex == 0) {
      getAllEvents(uId);
    } else {
      getFilterEvents(uId);
    }
  }
}
