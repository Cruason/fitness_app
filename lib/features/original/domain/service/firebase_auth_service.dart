import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthService{

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut() ;
  User? getCurrentUser();
}
