import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkinnapi/Screens/delete_transaction/delete_controller.dart';

import '../../Services/api/api_services.dart';
import '../../Services/shared_preference/shared_preference_services.dart';

class DeleteTransaction extends StatefulWidget {
  const DeleteTransaction({Key? key}) : super(key: key);

  @override
  State<DeleteTransaction> createState() => _DeleteTransactionState();
}

class _DeleteTransactionState extends State<DeleteTransaction> {
  DeleteController controller = DeleteController();
  bool? status;

  @override
  void initState() {
    super.initState();
    status = SharedService.checkStatus();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (status == null || status == false) {
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
      } else if (status == true) {
        var data = SharedService.getCustomerData();
        if (data != null) {
          controller.idController.text = data["userId"]!;
          controller.mobileController.text = data["userNumber"]!;
        } else {
          log(name: "Add vehicle", "Data load nhi hua");
        }
      } else {
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
        title: Text("Delete Transaction"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
                key: controller.mobileKey,
                child: TextFormField(
                  controller: controller.mobileController,
                  decoration: InputDecoration(
                      labelText: "Mobile Number", border: OutlineInputBorder()),
                )),
            SizedBox(
              height: 20,
            ),
            Form(
                key: controller.idKey,
                child: TextFormField(
                  controller: controller.idController,
                  decoration: InputDecoration(
                      labelText: "Customer ID", border: OutlineInputBorder()),
                )),
            ElevatedButton(
                onPressed: () async{
                  Get.defaultDialog(
                      middleText: "Are you sure?",
                      onConfirm: () async{
                        try {
                          await API.deleteTransaction(transactionBody: {
                            "mobileNumber": controller.mobileController.text,
                            "customerId": controller.idController.text
                          });
                          Get.snackbar("Current Transaction", "Deleted successfully!");
                        } on Exception catch (e) {
                          Get.snackbar("Current Transaction", "Something went wrong.");

                        }
                      });
                },
                child: Text("Delete"))
          ],
        ),
      ),
    );
  }
}
