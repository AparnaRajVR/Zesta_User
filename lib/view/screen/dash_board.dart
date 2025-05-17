

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';

import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/screen/Analytcs_page.dart';
import 'package:zesta_1/view/screen/profile_screen.dart';
import 'package:zesta_1/view/screen/ticket_screen.dart';
import 'package:zesta_1/view/widget/appbar_wdget.dart';
import 'package:zesta_1/view/widget/bottom_nav.dart';

import 'package:zesta_1/view/widget/event/category_event.dart';
import 'package:zesta_1/view/widget/event/event_carousel.dart';
import 'package:zesta_1/view/widget/event/recommented_item.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

enum SelectedTab { home, ticket, analytics, profile }

class DashboardController extends GetxController {
  var selectedTabIndex = 0.obs;
  void onTabSelected(int index) {
    selectedTabIndex.value = index;
  }
}

class Dashboard extends StatelessWidget {
  final EventController eventController = Get.find<EventController>();
  final LocationDialogController locationController = Get.put(LocationDialogController());
  final DashboardController dashboardController = Get.put(DashboardController());

  Dashboard({super.key});

  final List<Widget> pages = [
    const TicketScreen(), 
    const Analytics(), 
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() =>Scaffold(
      appBar: dashboardController.selectedTabIndex.value == SelectedTab.home.index
    ? AppBarWidget(locationController: locationController)
    : null,
      backgroundColor: AppColors.textlight,
      body: SafeArea(
        child: Obx(() {
          if (dashboardController.selectedTabIndex.value == SelectedTab.home.index) {
            if (eventController.allEvents.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 11),
                    CategoryIconWidget(),
                    const SizedBox(height: 18),
                    EventCarousel(events: eventController.allEvents),
                    const SizedBox(height: 16),
                    
                    RecommendedItemsWidget(events: eventController.allEvents),
                  ],
                ),
              ),
            );
          } else {
            int pageIndex = dashboardController.selectedTabIndex.value - 1;
            if (pageIndex >= 0 && pageIndex < pages.length) {
              return pages[pageIndex];
            } else {
              return const Center(child: Text("Page not found"));
            }
          }
        }),
      ),
      bottomNavigationBar: BottomNavWidget(
        selectedIndex: dashboardController.selectedTabIndex,
        onTabChange: dashboardController.onTabSelected,
      ),
    ));
  }
}

