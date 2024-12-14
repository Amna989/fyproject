import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Add user to Firestore
  Future<void> addUser(String userID, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(userID).set(userInfoMap);
      print("User added successfully to Firestore.");
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUser(String userID) async {
    try {
      DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection("Users").doc(userID).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print("No user found with ID: $userID");
        return null;
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      return null;
    }
  }

  // Check if a user is verified (additional functionality for email verification)
  Future<bool> isUserVerified(String userID) async {
    try {
      DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection("Users").doc(userID).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
        return userData['isEmailVerified'] ?? false;
      } else {
        print("No user found with ID: $userID");
        return false;
      }
    } catch (e) {
      print("Error checking email verification status: $e");
      return false;
    }
  }

  // Update email verification status
  Future<void> updateEmailVerificationStatus(String userID, bool isVerified) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .update({"isEmailVerified": isVerified});
      print("Email verification status updated successfully.");
    } catch (e) {
      print("Error updating email verification status: $e");
    }
  }
  // Method to update user data in Firestore
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).update(data);
      print("User updated successfully.");
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }

}
