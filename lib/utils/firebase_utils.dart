import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUserWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // User creation successful, you can navigate to another screen or perform additional tasks.
    print('User created: ${userCredential.user!.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    // Handle other exceptions as needed
  } catch (e) {
    print(e.toString());
  }
}
