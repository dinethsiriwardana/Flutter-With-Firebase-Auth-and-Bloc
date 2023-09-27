import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();

  Future<Map<String, dynamic>> signInWithEmailAndPassword(
      String email, String password);
  Future<Map<String, dynamic>> createUserWithEmailandPassword(
      String email, String password);
  Future<void> signOut();
  Future<void> deleteOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  //Stream Builder
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  // SignIn using Email
  Future<Map<String, dynamic>> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential =
        await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
      email: email,
      password: password,
    ));
    return {
      'status': "success",
      'user': userCredential.user,
    };
  }

  @override
  Future<Map<String, dynamic>> createUserWithEmailandPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return {
      'status': "success",
      'user': userCredential.user,
    };
  }

  @override
  Future<void> deleteOut() async {
    await currentUser!.delete(); //FirebaseAuth.instance.currentUser.delete
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
