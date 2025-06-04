
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Additions for image handling ---
  Rx<File?> pickedImage = Rx<File?>(null);
  RxString photoUrl = ''.obs;
  RxBool isUploading = false.obs;

  static const String _cloudName = 'dbu2ez12r'; // your cloud name
  static const String _uploadPreset = 'my_files'; // your upload preset

  void setInitialPhotoUrl(String? url) {
    if (url != null && url.isNotEmpty) {
      photoUrl.value = url;
    }
  }

  Future<void> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  Future<String?> uploadProfileImage() async {
    if (pickedImage.value == null) return null;
    try {
      isUploading.value = true;
      final cloudinary = CloudinaryPublic(_cloudName, _uploadPreset, cache: false);
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(pickedImage.value!.path, resourceType: CloudinaryResourceType.Image),
      );
      photoUrl.value = response.secureUrl;
      return response.secureUrl;
    } catch (e) {
      
      return null;
    } finally {
      isUploading.value = false;
    }
  }
  // --- End image handling additions ---

  Future<void> createProfile({
    required String fullName,
    required String email,
    String? bio,
    String? phone,
    List<String>? categories,
    String? photoUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user logged in.");

    await _firestore.collection('user_profiles').doc(user.uid).set({
      "uid": user.uid,
      "fullName": fullName,
      "email": email,
      "bio": bio ?? "",
      "phone": phone ?? "",
      "categories": categories ?? [],
      "photoUrl": photoUrl ?? "",
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateProfile({
    String? fullName,
    String? bio,
    List<String>? categories,
    String? photoUrl, // <-- Add this
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user logged in.");
    final data = <String, dynamic>{
      "updatedAt": FieldValue.serverTimestamp(),
    };
    if (fullName != null) data["fullName"] = fullName;
    if (bio != null) data["bio"] = bio;
    if (categories != null) data["categories"] = categories;
    if (photoUrl != null) data["photoUrl"] = photoUrl;

    await _firestore.collection('user_profiles').doc(user.uid).update(data);
  }

  Future<Map<String, dynamic>?> fetchProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final doc = await _firestore.collection('user_profiles').doc(user.uid).get();
    return doc.data();
  }
}








