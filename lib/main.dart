import 'package:apex_assessment/bindings/home_bindings.dart';
import 'package:apex_assessment/resources/theme.dart';
import 'package:apex_assessment/routes/app_pages.dart';
import 'package:apex_assessment/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Apex Assignment',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: MyTheme().getCurrentTheme(),

      initialBinding: HomeScreenBinding(),
      home: HomeScreen(),
    );
  }
}

