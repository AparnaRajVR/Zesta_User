import 'package:get/get.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/services/firebase_control.dart';

class InstanceBind extends Bindings{
  @override
  void dependencies() {
    
  Get.lazyPut<FirebaseControl>(()=>FirebaseControl());
  Get.lazyPut<EventController>(() => EventController());

  }

  
}

class ImageSliderController extends GetxController {
  var currentPage = 0.obs;
}

class DescriptionController extends GetxController {
  var expanded = false.obs;

  void toggle() => expanded.value = !expanded.value;
}
