import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/features/original/domain/service/firebase_auth_service.dart';

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Sign up error: $e");
      return null;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Sign in error: $e");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
