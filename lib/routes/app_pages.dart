import 'package:apex_assessment/bindings/home_bindings.dart';
import 'package:get/get.dart';

import '../screens/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeScreenBinding(),
    ),
  ];
}
