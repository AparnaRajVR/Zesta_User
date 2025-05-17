// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../view/screen/dash_board.dart';
// import '../view/screen/entry/login_screen.dart';

// class SocialAuth {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /// Facebook sign-in with role check in Firestore.
//   Future<void> facebookSignIn() async {
//     try {
//       // Start the Facebook login flow.
//       final LoginResult result = await FacebookAuth.instance.login();

//       if (result.status == LoginStatus.success && result.accessToken != null) {
//         // Get the access token string.
//         final String accessToken = result.accessToken!.token;

//         // Create a Firebase credential from the Facebook access token.
//         final OAuthCredential credential = FacebookAuthProvider.credential(accessToken);

//         // Sign in to Firebase with the Facebook credential.
//         final UserCredential userCredential = await _auth.signInWithCredential(credential);
//         final String uid = userCredential.user!.uid;

//         // Check user role in Firestore.
//         final DocumentSnapshot snapshot = await FirebaseFirestore.instance
//             .collection('zesta_user')
//             .doc(uid)
//             .get();

//         if (snapshot.exists && snapshot['role'] == 'zestauser') {
//           Get.offAll(() => Dashboard());
//         } else {
//           await _auth.signOut();
//           Get.snackbar("Access Denied", "Only Zesta Users are allowed.");
//         }
//       } else if (result.status == LoginStatus.cancelled) {
//         Get.snackbar("Login Cancelled", "Facebook login was cancelled by user.");
//       } else {
//         Get.snackbar("Login Failed", result.message ?? "Unknown error occurred.");
//       }
//     } catch (e) {
//       Get.snackbar("Facebook Sign-In Error", _getErrorMessage(e.toString()));
//     }
//   }

//   /// Facebook + Firebase sign out.
//   Future<void> signOut() async {
//     try {
//       await FacebookAuth.instance.logOut();
//       await _auth.signOut();
//       Get.offAll(() => LoginScreen());
//     } catch (e) {
//       Get.snackbar("Sign Out Error", _getErrorMessage(e.toString()));
//     }
//   }

//   String _getErrorMessage(String error) {
//     final RegExp errorPattern = RegExp(r'] (.+)');
//     final match = errorPattern.firstMatch(error);
//     return match?.group(1) ?? "An unexpected error occurred.";
//   }
// }
