
import 'package:firebase_auth/firebase_auth.dart';
class Authentication{
  FirebaseAuth auth=FirebaseAuth.instance;
  Stream<User?> get isAuthenticated{
    return auth.authStateChanges();
  }
  Future<void> signInWithEmail(String email,String password)async{

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception  {
      // TODO
      rethrow;
    }
  }
  Future<void> signupWithEmail(String email,String password)async{
      try {
        await auth.createUserWithEmailAndPassword(email: email, password: password);
      } on Exception  {
        // TODO
        rethrow;
      }
  }
  Future<void> signOut () async{
    await auth.signOut();
  }
}