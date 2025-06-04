import 'package:get/get.dart';

enum SelectedTab { home, ticket, analytics, profile }

class DashboardController extends GetxController {
  var selectedTabIndex = 0.obs;
  void onTabSelected(int index) {
    selectedTabIndex.value = index;
  }
}