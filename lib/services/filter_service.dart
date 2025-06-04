
import 'package:get/get.dart';
import 'package:zesta_1/services/event_controller.dart';

class FilterController extends GetxController {
  // Filters as Rx variables
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var minPrice = 0.0.obs;
  var maxPrice = 1000.0.obs;
  var includeFreeEvents = true.obs;
  var selectedLocation = 'All Locations'.obs;
  var availableLocations = <String>['All Locations'].obs;

  //  Nearby Filter
  var isNearby = false.obs;
  String userCity = ''; 

  bool isInitialized = false;
  var filteredEvents = [].obs;

  late final EventController eventController;

  ///  function to safely parse event date
  DateTime? parseEventDate(dynamic date) {
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String && date.isNotEmpty) {
      try {
        return DateTime.parse(date);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  void initialize(EventController eventController, String categoryLabel) {
    this.eventController = eventController;

    final locationSet = <String>{};
    for (var event in eventController.allEvents) {
      if (event.city != null && event.city!.isNotEmpty) {
        // Convert to proper case (first letter capital, rest lowercase)
        final properCaseCity = event.city!.trim().toLowerCase();
        final formattedCity = properCaseCity[0].toUpperCase() + properCaseCity.substring(1);
        locationSet.add(formattedCity);
      }
    }

    availableLocations.value = ['All Locations', ...locationSet];
    applyFilters(categoryLabel);
  }

  void applyFilters(String categoryLabel) {
    var filtered = eventController.allEvents.where((event) {
      final catId = event.categoryId;
      final catName = eventController.getCategoryName(catId ?? '');
      return catName.toLowerCase() == categoryLabel.toLowerCase();
    }).toList();

    // NEARBY Filter (Overrides selectedLocation if true)
    if (isNearby.value && userCity.isNotEmpty) {
      filtered = filtered.where((event) =>
        event.city?.toLowerCase() == userCity.toLowerCase()).toList();
    }
    // Location filter (only used if not nearby)
    else if (selectedLocation.value != 'All Locations') {
      filtered = filtered.where((event) =>
        event.city?.toLowerCase() == selectedLocation.value.toLowerCase()).toList();
    }

    // Date filter
    if (startDate.value != null || endDate.value != null) {
      filtered = filtered.where((event) {
        final eventDate = parseEventDate(event.date);
        if (eventDate == null) return false;
        if (startDate.value != null && eventDate.isBefore(startDate.value!)) return false;
        if (endDate.value != null && eventDate.isAfter(endDate.value!)) return false;
        return true;
      }).toList();
    }

    // Price filter
    filtered = filtered.where((event) {
      final price = event.ticketPrice ?? 0.0;
      if (price == 0 && !includeFreeEvents.value) return false;
      return price >= minPrice.value && price <= maxPrice.value;
    }).toList();

    filteredEvents.value = filtered;
  }

  void clearFilters(String categoryLabel) {
    startDate.value = null;
    endDate.value = null;
    minPrice.value = 0.0;
    maxPrice.value = 1000.0;
    includeFreeEvents.value = true;
    selectedLocation.value = 'All Locations';
    isNearby.value = false;
    applyFilters(categoryLabel);
  }

  // Set this from outside using LocationDialogController
  void setUserCity(String city) {
    userCity = city;
  }
}