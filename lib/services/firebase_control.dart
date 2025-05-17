
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zesta_1/view/screen/entry/welcome.dart';
import '../view/screen/entry/login_screen.dart';
import '../view/screen/dash_board.dart';

class FirebaseControl extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  var verificationId = "".obs;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  String? get userEmail => _firebaseUser.value?.email;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
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

      await FirebaseFirestore.instance
          .collection('zesta_user')
          .doc(userCredential.user!.uid)
          .set({
        "fullName": fullname,
        "email": email,
        "role": "zestauser",
        "uid": userCredential.user!.uid,
      });

      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar("Error", getErrorMessage(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user!.uid;

      final snapshot = await FirebaseFirestore.instance
          .collection('zesta_user')
          .doc(uid)
          .get();

      if (snapshot.exists && snapshot['role'] == 'zestauser') {
        Get.offAll(() => Dashboard());
      } else {
        await _auth.signOut();
        Get.snackbar("Access Denied", "Only Zesta Users are allowed.");
      }
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

      final userRef = FirebaseFirestore.instance.collection('zesta_user').doc(uid);
      final snapshot = await userRef.get();

      if (snapshot.exists) {
        if (snapshot['role'] == 'zestauser') {
          Get.offAll(() => Dashboard());
        } else {
          await _auth.signOut();
          Get.snackbar("Access Denied", "Only Zesta Users are allowed.");
        }
      } else {
        // First-time Google login — create user with default role
        await userRef.set({
          "fullName": googleUser.displayName ?? "",
          "email": googleUser.email,
          "role": "zestauser",
          "uid": uid,
        });
        Get.offAll(() => Dashboard());
      }
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

    final userRef = FirebaseFirestore.instance.collection('zesta_user').doc(user.uid);
    final snapshot = await userRef.get();

    if (snapshot.exists) {
      if (snapshot['role'] == 'zestauser') {
        Get.offAll(() => Dashboard());
      } else {
        await _auth.signOut();
        Get.snackbar("Access Denied", "Only Zesta Users are allowed.");
      }
    } else {
      await userRef.set({
        "fullName": "", // You can collect this from a profile form later
        "email": user.phoneNumber ?? "",
        "role": "zestauser",
        "uid": user.uid,
      });
      Get.offAll(() => Dashboard());
    }
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
