import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parkinnapi/Modals/customer_modal.dart';
import 'package:parkinnapi/Modals/vehicle_modal.dart';

import '../../Services/api/api_services.dart';

class AllCustomerScreen extends StatelessWidget {
  AllCustomerScreen({Key? key}) : super(key: key);
  List<dynamic> allCustomersList = [];
  List<Customer> allCustomers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Customers"),
      ),
      body: FutureBuilder(
        future: API.getAllCustomers(),
        builder: (BuildContext context, AsyncSnapshot<List<Customer>> customerListSnapshot) {
          if (customerListSnapshot.hasData) {
            log(name: "All customer screen", "Data received successfully");
            // log(name: "All customer screen", "${snapshot.data![0]}");

            allCustomers = customerListSnapshot.data!;

            log(
                name: "All customer screen",
                "List Converted successfully: ${allCustomers.length}");

            // allCustomersList = json.decode(snapshot.data);
            // log(name: "All Customers","${allCustomersList.length}");

            return Container(
              padding: const EdgeInsets.all(7),
              child: ListView.builder(
                  itemCount: allCustomers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        // todo add a check for handling the empty data for now toString daal rhe hai
                        title: Text(allCustomers[index].mobileNumber.toString()),
                        subtitle: Text(allCustomers[index].customerId.toString()),
                        onTap: () {
                        Get.defaultDialog(
                          title: "ParkInn User Details",
                          content: Column(children: [
                            Text("Customer Id  : ${allCustomers[index].customerId}",textAlign: TextAlign.center),
                            Text("Mobile Number: ${allCustomers[index].mobileNumber} ",textAlign: TextAlign.center),
                            Text("Balance      : ${allCustomers[index].balance} ",textAlign: TextAlign.center),
                            Text("Date : ${allCustomers[index].createDate} ",textAlign: TextAlign.center),

                            // todo Handle empty data
                            Text("History : ${allCustomers[index].history!.isEmpty? "No past record":allCustomers[index].history} ",textAlign: TextAlign.center),
                            Text("Vehicles : ${allCustomers[index].vehicles!.isEmpty? "No past record":allCustomers[index].vehicles![0].getVehicleNumber.toString()} ",textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis),
                            Text("All Vehicles : ${allCustomers[index].allVehicles!.isEmpty? "No past record":allCustomers[index].allVehicles![0].toString()} ",textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis),



                          ],)

                        );
                        },
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
