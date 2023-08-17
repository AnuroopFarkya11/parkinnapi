import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Modals/customer_modal.dart';
import '../../Services/api/api_services.dart';
import 'controller.dart';

// todo ERROR HANDLING NHI HUI HAIIII

class CustomerScreen extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());

  CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer")),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: controller.mobileKey,
              child: TextFormField(
                controller: controller.mobileNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Mobile Number"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your mobile number";
                  }
                  if (value.length < 4) {
                    return "Enter a valid number";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: controller.otpKey,
              child: TextFormField(
                controller: controller.otpNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "OTP"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your otp";
                  }
                  if (value.length < 4) {
                    return "Enter a valid otp";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.mobileKey.currentState!.validate() &&
                    controller.otpKey.currentState!.validate()) {
                  Get.defaultDialog(
                      title: "User Detail",
                      content: FutureBuilder(
                          future: API.createUser(
                              controller.mobileNumberController.text,
                              controller.mobileNumberController.text),
                          builder: (BuildContext context,
                              AsyncSnapshot<Customer> snapshot) {
                            // todo what does connectionstate.active is responsible
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
                                      "CURRENT TRANSACTION: ${customer.currentTransaction}"),
                                  Text(
                                    "VEHICLES: ${customer.vehicles}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "ALL VEHICLES: ${customer.allVehicles}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );

                            /*  if(snapshot.connectionState==ConnectionState.active)
                          {
                            if(!snapshot.hasError){
                              // todo show an error occurred message at centre

                              return Center(child: Text(snapshot.error.toString()),);

                            }
                            return Container();
                            // todo here retur the content


                          }
                        else{

                          // todo show a progress indicator
                          return Container();

                        }*/
                          }));
                }
              },
              child: const Text("Login"),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            )
          ],
        ),
      ),
    );
  }
}
