import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      return result.user;
    } catch (e) {
      throw Exception('An unexpected error occurred during sign-in: $e');
    }
  }

  Future<void> signUpAnon() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String name,
    String role,
  ) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final CollectionReference firebaseCollection = FirebaseFirestore.instance
          .collection(role);
      await firebaseCollection.doc(result.user?.uid).set({
        'name': name,
        'email': email,
        'role': role,
      });
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw (e.toString());
    }
  }
}
