import 'package:evently/firebase_utils.dart';
import 'package:evently/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount googleUser =
  await GoogleSignIn.instance.authenticate();

  final GoogleSignInAuthentication googleAuth =
      googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
  );

  final userCredential =
  await FirebaseAuth.instance.signInWithCredential(credential);

  final firebaseUser = userCredential.user!;


  final existingUser =
  await FirebaseUtils.readUserFromFireStore(firebaseUser.uid);


  if (existingUser == null) {
    final myUser = MyUser(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
    );

    await FirebaseUtils.addUserToFireStore(myUser);
  }

  return userCredential;
}