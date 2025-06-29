import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/services/dashboard_controller.dart';

import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/screen/favourite_page.dart';
import 'package:zesta_1/view/screen/profile_screen.dart';
import 'package:zesta_1/view/screen/ticket_screen.dart';
import 'package:zesta_1/view/widget/appbar_wdget.dart';
import 'package:zesta_1/view/widget/bottom_nav.dart';

import 'package:zesta_1/view/widget/event/category_event.dart';
import 'package:zesta_1/view/widget/filter/category_filter.dart';
import 'package:zesta_1/view/widget/event/event_carousel.dart';
import 'package:zesta_1/view/widget/event/past_event_view.dart';
import 'package:zesta_1/view/widget/event/recommented_item.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

class Dashboard extends StatelessWidget {
  final EventController eventController = Get.find<EventController>();
  final LocationDialogController locationController =
      Get.put(LocationDialogController());
  final DashboardController dashboardController =
      Get.put(DashboardController());

  Dashboard({super.key});

  final List<Widget> pages = [
    const TicketScreen(),
    const FavoritesPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: dashboardController.selectedTabIndex.value ==
                  SelectedTab.home.index
              ? AppBarWidget(locationController: locationController)
              : null,
          backgroundColor: AppColors.textlight,
          body: SafeArea(
            child: Obx(() {
              if (dashboardController.selectedTabIndex.value ==
                  SelectedTab.home.index) {
                if (eventController.allEvents.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 11),
                        CategoryIconWidget(
                          onCategoryTap: (label) {
                            // Navigate to the filtered events grid page
                            Get.to(() => FilteredEventsGridPage(
                                  categoryLabel: label,
                                  // locationController:
                                  //     Get.find<LocationDialogController>(),
                                ));
                          },
                        ),
                        const SizedBox(height: 18),
                        EventCarousel(events: eventController.upcomingEvents),
                        const SizedBox(height: 16),
                        RecommendedItemsWidget(
                            events:
                                eventController.upcomingEventsByUserInterest),
                        const SizedBox(height: 21),
                        PastEventsHorizontalList(
                            events: eventController.allEvents),
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
