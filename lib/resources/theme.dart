
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTheme extends GetxController {

  static final MyTheme _singleton = MyTheme._internal();

  factory MyTheme() {
    return _singleton;
  }

  MyTheme._internal();

  final _isDark = false.obs;
  get themeValue => _isDark;



  ThemeMode getCurrentTheme() {
    return _isDark.value ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark.value = !_isDark.value;

    update();
    if (themeValue == true) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}