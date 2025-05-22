import 'package:get/get.dart';

class EventFilterController extends GetxController {
  var selectedLocation = ''.obs;
  var isFree = RxnBool(); 
  var distanceSort = ''.obs; 
  var selectedDate = Rxn<DateTime>();

}
