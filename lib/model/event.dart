import '../firebase_utils.dart';

class Event {  //data class , model

  static const String collectionName="Events";


  String id;
  String title;
  String description;
  String date;
  String time;
  String image;
  bool isFavorite;
  DateTime dateTime;
  String eventName;
  double lat;
  double long;
  Event({this.id="",required this.title,required this.description,
    required this.date,required this.time,required this.image,
    this.isFavorite=false,required this.dateTime,required this.eventName
  ,this.lat=0,this.long=0

  });



Event.fromFireStore(Map<String,dynamic>data):this(
  //json=>object

  eventName:data["eventname"]??"" ,
  dateTime:DateTime.fromMillisecondsSinceEpoch (data["datetime"]??0),
    time: data["time"]?? "",
  date: data["date"]??"",
  description:data["description"]?? "" ,
  image: data["image"]?? "",
  title: data["title"]?? "",
  isFavorite: data["isfavorite"]?? false,
  id: data["id"]?? "",
  lat: data["lat"]?? 0,
  long: data["long"]?? 0,

);






  Map<String,dynamic> toFireStore(){//object=>json
    return{
 "id":id,
 "title":title,
      "description":description,
      "date":date,
      "time":time,
      "image":image,
      "isfavorite":isFavorite,
      "datetime":dateTime.millisecondsSinceEpoch,
      "eventname":eventName,
      "lat":lat,
      "long":long,

    };


}
  void debugAllEvents(String uId) async {
    var snapshot = await FirebaseUtils.getEventCollection(uId).get();

    for (var doc in snapshot.docs) {
      print("RAW: ${doc.data().toFireStore()}");
    }
  }

}