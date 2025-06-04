
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zesta_1/view/screen/dash_board.dart';

class CategorySelectController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  final RxList<String> selectedCategories = <String>[].obs;

  final _firestore = FirebaseFirestore.instance;
  //  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('event_categories').get();
      categories.assignAll(snapshot.docs.map((doc) => {
            'id': doc.id,
            'name': doc['name'],
          }));
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCategory(String categoryName) {
    if (selectedCategories.contains(categoryName)) {
      selectedCategories.remove(categoryName);
    } else {
      selectedCategories.add(categoryName);
    }
  }

  
Future<void> saveCategoriesAndProceed() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  await FirebaseFirestore.instance.collection('user_profiles').doc(uid).update({
    'categories': selectedCategories.toList(),
  });
  Get.offAll(() => Dashboard());
}


}
