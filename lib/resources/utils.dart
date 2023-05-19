import 'package:apex_assessment/resources/theme.dart';
import 'package:flutter/material.dart';

class Utils{

  MyTheme currentTheme = MyTheme();

  Widget sizeVer(double height) {
    return SizedBox(height: height,);
  }

  Widget sizeHor(double width) {
    return SizedBox(width: width);
  }

}