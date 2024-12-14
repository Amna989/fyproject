import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Service/Database.dart'; // Import DatabaseMethods class

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseMethods _databaseMethods = DatabaseMethods(); // Create instance of DatabaseMethods

  // Get the current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // Sign in with Google
  Future<Map<String, dynamic>?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign-in, return null
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In canceled.')),
        );
        return null;
      }

      // Obtain the authentication details from the Google sign-in process
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a credential for Firebase authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // If sign-in is successful, extract user details
      if (userCredential.user != null) {
        User? user = userCredential.user;

        // Create a map to store user details
        Map<String, dynamic> userInfoMap = {
          "email": user?.email,
          "name": user?.displayName,
          "imageUrl": user?.photoURL,
          "id": user?.uid,
        };

        // Store user data in Firestore
        await _databaseMethods.addUser(user?.uid ?? "", userInfoMap);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-In Successful: ${user?.displayName ?? ''}'),
          ),
        );

        // Return the user information map
        return userInfoMap;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In failed: User is null.')),
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Firebase Error: ${e.message}')),
      );
      return null;
    } catch (e) {
      // Handle any other unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
      return null;
    }
  }

  // Sign out function
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}

