import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/foundation.dart';

class EventListProvider extends ChangeNotifier {


  List<Event> eventsList = [];
  List<Event>filterEventList = [] ;
  List<String> eventsNameList = [
    "All",
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
  int Selectedindex = 0;
  void getAllEvents() async {
    QuerySnapshot<Event> querysnapshot =
        await FirebaseUtils.getEventCollection().get();

    eventsList = querysnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    //sorting
    eventsList.sort((Event event1,Event event2){
      return event1.dateTime.compareTo(event2.dateTime);


    });

filterEventList=eventsList;


    notifyListeners();
   }

  void getFilterEvents() async {
    QuerySnapshot<Event> querysnapshot =
    await FirebaseUtils.getEventCollection().get();

    eventsList = querysnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    filterEventList=eventsList.where((event){

      return event.eventName==eventsNameList[Selectedindex];

    }).toList();





    notifyListeners();
  }




  void changeSelectedEvent(int newSelectedIndex) {
    Selectedindex = newSelectedIndex;

    if (Selectedindex == 0) {
      getAllEvents();
    }else{
    getFilterEvents();
  }}

}
