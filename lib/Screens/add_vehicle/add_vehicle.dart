import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parkinnapi/Screens/add_vehicle/controller.dart';
class AddVehicles extends StatelessWidget {
  final AddVehicleController controller = Get.put(AddVehicleController());
  AddVehicles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      appBar: AppBar(title: const Text("Add Vehicle"),),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(

          children: [

            Form(
              key:controller.mobileKey,
              child: TextFormField(
                controller: controller.mobileController,
              ),
            ),
            const SizedBox(height: 20,),
            Form(
              key: controller.customerIdKey,
              child:TextFormField(
                controller: controller.customerIdController,
              ),
            ),

            const SizedBox(height: 20,),
            Form(
              key: controller.vehicleTypeKey,
              child:TextFormField(
                controller: controller.vehicleTypeController,
              ),
            ),






          ],



        ),
      ),
    );
  }
}
