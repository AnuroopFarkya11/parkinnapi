import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkinnapi/Services/shared_preference/shared_preference_services.dart';

import 'Screens/homescreen/home_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedService.initializePreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

