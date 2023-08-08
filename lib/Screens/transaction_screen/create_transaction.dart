import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkinnapi/Screens/transaction_screen/create_controller.dart';

import '../../Modals/customer_modal.dart';
import '../../Services/api/api_services.dart';
class CreateTransaction extends StatefulWidget {
  const CreateTransaction({Key? key}) : super(key: key);

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  CreateTransactionController controller = Get.put(CreateTransactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Transaction"),
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
