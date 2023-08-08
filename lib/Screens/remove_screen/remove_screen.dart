import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkinnapi/Screens/homescreen/home_screen.dart';
import 'package:parkinnapi/Services/shared_preference/shared_preference_services.dart';

import '../../Services/api/api_services.dart';

class RemoveScreen extends StatefulWidget {
  const RemoveScreen({Key? key}) : super(key: key);

  @override
  State<RemoveScreen> createState() => _RemoveScreenState();
}

class _RemoveScreenState extends State<RemoveScreen> {
  bool? status;
  late String custId;
  late String custNumber;

  @override
  void initState() {
    super.initState();
    status = SharedService.checkStatus();
    if (status == true) {
      var data = SharedService.getCustomerData();
      if (data != null) {
        custId = data["userId"]!;
        custNumber = data["userNumber"]!;
      } else {
        log(name: "Remove vehicle", "Data load nhi hua");
      }
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (status == null || status == false) {
          Get.defaultDialog(
              barrierDismissible: false,
              title: "LOGIN WARNING",
              middleText:
                  "You are not logged in. Do you still wanna continue?!",
              onConfirm: () {
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
                // Get.off(()=>LoginScreen());
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remove Vehicle"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: status == true
            ? FutureBuilder(
                future: API.getCustomerAllVehicles(
                    customerNumber: custNumber, customerId: custId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      padding: EdgeInsets.all(12),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].vehicleNumber),
                            trailing: Text(snapshot.data![index].vehicleType),
                            subtitle: Text(snapshot.data![index].date),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : Center(
                child: Text("Please login"),
              ),
      ),
    );
  }
}
