import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parkinnapi/Screens/loginCustomer/controller.dart';

import '../../Modals/customer_modal.dart';
import '../../Services/api/api_services.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
                  controller: controller.mobileController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your number";
                    }
                    if (value.length < 4) {
                      return "Please enter valid number";
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Mobile Number"),
                )),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: controller.customerIdKey,
                child: TextFormField(
                  controller: controller.customerIdController,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your customer id";
                    }
                    // if(value.length<4)
                    //   {
                    //     return "Please enter valid customer Id";
                    //   }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Customer Id"),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.mobileKey.currentState!.validate() &&
                    controller.customerIdKey.currentState!.validate()) {
                  Get.defaultDialog(
                      title: "Login Status",
                      content: FutureBuilder(
                          future: API.loginUser(
                              controller.mobileController.text,
                              controller.customerIdController.text),
                          builder: (context, snapshot) {

                            if(snapshot.connectionState==ConnectionState.done)
                              {
                                if(snapshot.hasError)
                                  {
                                    return Center(child: Text(snapshot.error.toString()),);
                                  }

                                Customer? customer = snapshot.data;
                                return Column(
                                  children: [
                                    Text("CUSTOMER NUMBER: ${customer!.mobileNumber}"),
                                    Text("CUSTOMER ID: ${customer.customerId}"),
                                    Text("DATE: ${customer.createDate}"),
                                    Text("BALANCE: ${customer.balance}"),
                                    Text("HISTORY: ${customer.history}"),
                                    Text("CURRENT TRANSACTION: ${customer.currentTransaction}"),
                                    Text("VEHICLES: ${customer.vehicles}",overflow: TextOverflow.ellipsis,),
                                    Text("ALL VEHICLES: ${customer.allVehicles}",overflow: TextOverflow.ellipsis,),
                                  ],
                                );
                              }

                            return const Center(child: CircularProgressIndicator(),);


                          }
                          )
                  );
                }
              },
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
