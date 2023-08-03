import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parkinnapi/homescreen/home_controller.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("ParkInn API"),),
      body: Container(),


    );
  }
}
