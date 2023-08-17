import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkinnapi/Screens/admin/admin_controller.dart';
import 'package:parkinnapi/Screens/admin/start_parking_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.all(8),
              elevation: 5,
              child: ListTile(
                title: Text("Start Parking"),
                onTap: () {
                  Get.to(StartParking());
                },
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              elevation: 5,
              child: ListTile(
                title: Text("End Parking"),
                onTap: () {
                  Get.to(StartParking());
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
