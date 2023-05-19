import 'package:get/get.dart';

import '../view_models/home/home_view_model.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel());
  }
}
