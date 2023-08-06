import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parkinnapi/Screens/add_vehicle/add_vehicle.dart';
import 'package:parkinnapi/Screens/getAllCustomer/get_all_customer.dart';
import 'package:parkinnapi/Screens/loginCustomer/login_customer_screen.dart';
import '../createcustomer/customer_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParkInn API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Get all Customers"),
                onTap: () {
                  Get.to(() => AllCustomerScreen());
                },
              ),
            ),

            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Get/Create a customer"),
                onTap: () {
                  Get.to(() => CustomerScreen());
                },
              ),
            ),
            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Login"),
                onTap: () {
                  Get.to(() => LoginScreen());
                },
              ),
            ),
            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Add Vehicle"),
                onTap: () {
                  Get.to(() => AddVehicles() );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
