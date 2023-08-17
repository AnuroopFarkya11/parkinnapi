import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Modals/customer_modal.dart';
import '../../Services/api/api_services.dart';
import 'admin_controller.dart';

class EndParking extends StatelessWidget {
  const EndParking({Key? key}) : super(key: key);

  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                  key: controller.adminId,
                  child: TextFormField(
                    controller: controller.adminIdController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Admin Id",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Admin Id";
                      }
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: controller.adminPassword,
                  child: TextFormField(
                    controller: controller.adminPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Admin Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Admin password";
                      }
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: controller.mobileNumber,
                  child: TextFormField(
                    controller: controller.mobileNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mobile Number",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Mobile Number";
                      }
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: controller.transactionId,
                  child: TextFormField(
                    controller: controller.transactionIdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Transaction Id",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Transaction Id";
                      }
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async{
                    // Customer customer = await API.endParking(
                    //     controller.adminIdController.text,
                    //     controller.adminPasswordController.text,
                    //     controller.mobileNumberController.text,
                    //     controller.transactionIdController.text);
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()))
            ],
          ),
        ));  }
}
