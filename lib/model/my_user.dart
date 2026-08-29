class MyUser {

  static const String collectionName="MyUser";

  String name;
  String id;
  String email;
    MyUser({ required this.name,required this.email,required this.id });


    MyUser.fromFireStore(Map<String,dynamic>?data):this(

      name: data!["name"]as String,
      id: data["id"] as String,
      email: data["email"] as String,

    );

Map<String,dynamic>toFireStore(){

  return{

    "name":name ,
    "id":id,
    "email":email,

  };
}

}