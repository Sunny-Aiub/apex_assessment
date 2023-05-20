import 'package:apex_assessment/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Utils {
  MyTheme currentTheme = MyTheme();

  Widget sizeVer(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget sizeHor(double width) {
    return SizedBox(width: width);
  }

  TextStyle getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return GoogleFonts.roboto(
        fontSize: fontSize, fontWeight: fontWeight,
      color: MyTheme().getCurrentTheme() == ThemeMode.dark ? Colors.white : color,
    );
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static snackBar(String title, String message){
    Get.snackbar(title, message,backgroundColor: Colors.red);
  }
  static successSnackBar(String title, String message){
    Get.snackbar(title, message,backgroundColor: Colors.green,duration: Duration(seconds: 6),);
  }

}
