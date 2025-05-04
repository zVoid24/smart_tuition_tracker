import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_tuition_tracker/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmail({
    required String email,
    required String password,
    required bool rememberMe
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      if (result.user != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('remember_me', rememberMe);
      }
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
      // Step 1: Create user with Firebase Authentication
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Step 2: Store user data in Firestore
      final CollectionReference firebaseCollection = FirebaseFirestore.instance
          .collection(role);
      await firebaseCollection.doc(result.user?.uid).set({
        'name': name,
        'email': email,
        'role': role,
      });
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Authentication errors
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'Authentication error: ${e.message}';
      }
      print('FirebaseAuthException: $errorMessage'); // Debug log
      throw Exception(errorMessage);
    } on FirebaseException catch (e) {
      // Handle Firestore errors
      String errorMessage;
      switch (e.code) {
        case 'permission-denied':
          errorMessage = 'Permission denied. Please check Firestore rules.';
          break;
        case 'unavailable':
          errorMessage = 'Firestore is unavailable. Please check your network.';
          break;
        default:
          errorMessage = 'Firestore error: ${e.message}';
      }
      print('FirebaseException: $errorMessage'); // Debug log
      throw Exception(errorMessage);
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e'); // Debug log
      throw Exception('An unexpected error occurred during sign-up: $e');
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

  Future<UserInformation> getUserData() async {
    final userData = _firebaseAuth.currentUser;
    if (userData != null) {
      final CollectionReference firebaseCollectionstudent = FirebaseFirestore
          .instance
          .collection('student');
      final CollectionReference firebaseCollectionteacher = FirebaseFirestore
          .instance
          .collection('teacher');
      final userSnapshotstudent =
          await firebaseCollectionstudent.doc(userData.uid).get();
      final userSnapshotteacher =
          await firebaseCollectionteacher.doc(userData.uid).get();
      if (userSnapshotstudent.exists) {
        final data = userSnapshotstudent.data() as Map<String, dynamic>;
        return UserInformation(
          name: data['name'] ?? 'Unknown',
          email: data['email'] ?? 'Unknown',
          role: 'Student',
        );
      } else if (userSnapshotteacher.exists) {
        final data = userSnapshotteacher.data() as Map<String, dynamic>;
        return UserInformation(
          name: data['name'] ?? 'Unknown',
          email: data['email'] ?? 'Unknown',
          role: 'Teacher',
        );
      } else {
        throw Exception('User data not found in Firestore.');
      }
    }
    throw Exception('No authenticated user found.');
  }
}
