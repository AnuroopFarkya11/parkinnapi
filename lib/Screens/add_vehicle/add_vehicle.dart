import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:parkinnapi/Screens/add_vehicle/controller.dart';
import 'package:parkinnapi/Screens/loginCustomer/login_customer_screen.dart';
import 'package:parkinnapi/Services/shared_preference/shared_preference_services.dart';

import '../../Modals/customer_modal.dart';
import '../../Services/api/api_services.dart';

class AddVehicles extends StatefulWidget {
  AddVehicles({Key? key}) : super(key: key);

  @override
  State<AddVehicles> createState() => _AddVehiclesState();
}

class _AddVehiclesState extends State<AddVehicles> {
  final AddVehicleController controller = Get.put(AddVehicleController());
  bool? status;

  @override
  void initState() {
    super.initState();
    // Map<String?,String?>? userData = SharedService.getCustomerData();
    status = SharedService.checkStatus();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (status == null||status==false) {
        Get.defaultDialog(
            barrierDismissible: false,
            title: "LOGIN WARNING",
            middleText: "You are not logged in. Do you still wanna continue?!",
            onConfirm: () {
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
              // Get.off(()=>LoginScreen());
            });
      }
      else if(status==true){

        var data = SharedService.getCustomerData();
        if(data!=null)
          {
            controller.customerIdController.text = data["userId"]!;
            controller.mobileController.text = data["userNumber"]!;
          }
        else{
          log(name:"Add vehicle","Data load nhi hua");
        }


      }else {
        // Get.snackbar("Login Status", "You are logged out",snackPosition: SnackPosition.BOTTOM);
      }
      // if(userData!=null)
      // {
      //   controller.mobileController.text = userData['userId']!;
      //   controller.customerIdController.text = userData['userNumber']!;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Vehicle"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: controller.mobileKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your mobile number";
                  }
                },
                controller: controller.mobileController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Mobile Number"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: controller.customerIdKey,
              child: TextFormField(
                controller: controller.customerIdController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Customer ID";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Custormer ID"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: controller.vehicleNumberKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your vehicle number";
                  }
                },
                controller: controller.vehicleNumberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Vehicle Number"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: controller.vehicleTypeKey,
              child: TextFormField(
                controller: controller.vehicleTypeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your vehicle type";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Vehicle Type"),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.mobileKey.currentState!.validate() &&
                    controller.customerIdKey.currentState!.validate() &&
                    controller.vehicleNumberKey.currentState!.validate() &&
                    controller.vehicleTypeKey.currentState!.validate()) {
                  Get.defaultDialog(
                      content: FutureBuilder(
                          future: API.addVehicle(
                              mobileNumber:controller.mobileController.text,
                              customerId:controller.customerIdController.text,
                              vehicleType:controller.vehicleTypeController.text,
                              vehicleNumber:controller.vehicleNumberController.text
                          ),
                          builder: (builder, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              Customer? customer = snapshot.data;
                              return Column(
                                children: [
                                  Text(
                                      "CUSTOMER NUMBER: ${customer!.mobileNumber}"),
                                  Text("CUSTOMER ID: ${customer.customerId}"),
                                  Text("DATE: ${customer.createDate}"),
                                  Text("BALANCE: ${customer.balance}"),
                                  Text("HISTORY: ${customer.history}"),
                                  Text(
                                      "CURRENT TRANSACTION:  ${customer.currentTransaction}"),
                                  Text(
                                    "VEHICLES: ${customer.vehicles}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.bottomSheet(BottomSheet(
                                            onClosing: () {},
                                            builder: (context) {
                                              return ListView.builder(
                                                  padding: EdgeInsets.all(12),
                                                  itemCount: customer
                                                      .allVehicles!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      elevation: 20,
                                                      child: ListTile(
                                                        title: Text(customer
                                                            .allVehicles![index]
                                                            .vehicleNumber),
                                                        subtitle: Text(customer
                                                            .allVehicles![index]
                                                            .date),
                                                        trailing: Text(customer
                                                            .allVehicles![index]
                                                            .vehicleType),
                                                      ),
                                                    );
                                                  });
                                            }));
                                      },
                                      child: Text('All vehicles'))
                                  // TextButton("ALL VEHICLES: ${customer.allVehicles}",overflow: TextOverflow.ellipsis,),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }));
                }
              },
              child: Text("Add"),
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            )
          ],
        ),
      ),
    );
  }
}
