

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zesta_1/services/profile_controller.dart';
import 'package:zesta_1/view/screen/entry/category_select.dart';
import 'package:zesta_1/view/screen/entry/welcome.dart';
import '../view/screen/entry/login_screen.dart';
import '../view/screen/dash_board.dart';

class FirebaseControl extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  var verificationId = "".obs;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final ProfileController _profileController = ProfileController();
  
  



  String? get userEmail => _firebaseUser.value?.email;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  // Helper: Check if user has selected categories, and navigate accordingly
Future<void> _navigateAfterAuth(User user) async {
  final userRef = FirebaseFirestore.instance.collection('user_profiles').doc(user.uid);
  final snapshot = await userRef.get();
  final data = snapshot.data();

  // Defensive: categories must be a non-empty list
  final categories = data?['categories'];
  if (categories == null || categories is! List || categories.isEmpty) {
    Get.offAll(() => CategorySelectPage());
  } else {
    Get.offAll(() => Dashboard());
  }
}


  Future<void> createUser(
      String fullname, String email, String password, String confirmpassword) async {
    if (password != confirmpassword) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create user profile in user_profiles collection
      await _profileController.createProfile(
        fullName: fullname,
        email: email,
      );

      await _navigateAfterAuth(userCredential.user!);
    } catch (e) {
      Get.snackbar("Error", getErrorMessage(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      await _navigateAfterAuth(userCredential.user!);
    } catch (e) {
      Get.snackbar("Error while signing in", getErrorMessage(e.toString()));
    }
  }

  Future<void> googleSignIN() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final uid = userCredential.user!.uid;

      final userRef = FirebaseFirestore.instance.collection('user_profiles').doc(uid);
      final snapshot = await userRef.get();

      if (!snapshot.exists) {
        // First-time Google login — create user profile
        await _profileController.createProfile(
          fullName: googleUser.displayName ?? "",
          email: googleUser.email,
        );
      }
      await _navigateAfterAuth(userCredential.user!);
    } catch (e) {
      String errorMessage = getErrorMessage(e.toString());
      Get.snackbar("Google Sign-In Error", errorMessage);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      Get.offAll(() => WelcomeScreen());
    } catch (e) {
      String errorMessage = getErrorMessage(e.toString());
      Get.snackbar("Error while signing out", errorMessage);
    }
  }

  Future<void> phoneAuthentication(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (credentials) async {
        final result = await _auth.signInWithCredential(credentials);
        await _handlePhoneAuthUser(result.user);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again');
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );
      await _handlePhoneAuthUser(credentials.user);
      return credentials.user != null;
    } catch (e) {
      Get.snackbar("Error", "OTP verification failed.");
      return false;
    }
  }

  Future<void> _handlePhoneAuthUser(User? user) async {
    if (user == null) return;

    final userRef = FirebaseFirestore.instance.collection('user_profiles').doc(user.uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) {
      await _profileController.createProfile(
        fullName: "",
        email: user.phoneNumber ?? "",
      );
    }
    await _navigateAfterAuth(user);
  }

  void sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((_) {
      Get.offAll(LoginScreen());
      Get.snackbar("Success", "Password reset email link has been sent");
    }).catchError((onError) {
      Get.snackbar("Error in Email Reset", onError.message);
    });
  }

  String getErrorMessage(String error) {
    final RegExp errorPattern = RegExp(r'] (.+)');
    final match = errorPattern.firstMatch(error);
    return match?.group(1) ?? "An unexpected error occurred.";
  }
}
