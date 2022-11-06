import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:out_of_stock/controller/database_controller.dart';
import 'package:out_of_stock/controller/home_controller.dart';
import 'package:out_of_stock/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  HomeController homeController = Get.put(HomeController());
  DataBaseController dataBaseController = Get.put(DataBaseController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xff937DA8, <int, Color> {
          50: Color(0xff937DA8),
          100: Color(0xff937DA8),
          200: Color(0xff937DA8),
          300: Color(0xff937DA8),
          400: Color(0xff937DA8),
          500: Color(0xff937DA8),
          600: Color(0xff937DA8),
          700: Color(0xff937DA8),
          800: Color(0xff937DA8),
          900: Color(0xff937DA8),
        })
      ),
      home: HomeScreen(),
    );
  }
}
