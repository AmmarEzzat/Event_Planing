import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection().doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, options) =>
          Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, _) => event.toFireStore(),
    );
  }

  static Future<void> addEventToFireStore(Event event,String uId) {
    var collection = getEventCollection(uId);
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static CollectionReference<MyUser> getUserCollection() {
    return  FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()),


       toFirestore: (myUser, _) =>myUser.toFireStore() ,);
  }

  static Future<MyUser?> readUserFromFireStore (String id)async{

    var querySnapshot=await getUserCollection().doc(id).get();
return querySnapshot.data();
  }

static Future <void> addUserToFireStore(MyUser myUser){

    return getUserCollection().doc(myUser.id).set(myUser);

}

}
