import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parkinnapi/Screens/add_vehicle/add_vehicle.dart';
import 'package:parkinnapi/Screens/admin/admin_screen.dart';
import 'package:parkinnapi/Screens/getAllCustomer/get_all_customer.dart';
import 'package:parkinnapi/Screens/loginCustomer/login_customer_screen.dart';
import 'package:parkinnapi/Screens/remove_screen/remove_screen.dart';
import 'package:parkinnapi/Screens/transaction_screen/create_transaction.dart';
import '../createcustomer/customer_screen.dart';
import '../delete_transaction/delete_transaction.dart';
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
                  Get.to(() => AddVehicles());
                },
              ),
            ),
            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Remove Vehicle"),
                onTap: () {
                  Get.to(() => RemoveScreen());
                },
              ),
            ),
            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Create Transaction"),
                onTap: () {
                  Get.to(() => CreateTransaction());
                },
              ),
            ),
            Card(
              elevation: 20,
              child: ListTile(
                title: const Text("Delete Transaction"),
                onTap: () {
                  Get.to(() => DeleteTransaction());
                },
              ),
            ),
            Card(
              elevation: 20,
              child: ListTile(
                title: Text("Admin"),
                onTap: () {
                  Get.to(() => AdminScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
