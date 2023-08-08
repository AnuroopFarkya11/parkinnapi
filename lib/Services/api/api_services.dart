import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../Modals/customer_modal.dart';
import '../../Modals/transaction_modal.dart';
import '../../Modals/vehicle_modal.dart';

class API {
  static http.Client client = http.Client();

  static const String defaultAPI =
      "https://aquamarine-turkey-gear.cyclic.cloud";

  // this is a get method will be used to get the list of all the customers
  static Future<List<Customer>> getAllCustomers() async {
    String allCustomer =
        "https://aquamarine-turkey-gear.cyclic.cloud/api/customer/getAll";
    List<dynamic> allCustomersDynamicList = [];
    List<Customer> customerList = [];
    List<Vehicle> vehicleList = [];
    List<Vehicle> allVehicleList = [];

    Uri url = Uri.parse(allCustomer);
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        log(name: "GetAll API:", "Response Successful");
        log(name: "GetAll API:", response.body);

        allCustomersDynamicList = json.decode(response.body);

        customerList = allCustomersDynamicList.map((object) {

          return Customer(
              mobileNumber: object['mobileNumber'],
              customerId: object['customerId'],
              balance: object['balance'],
              currentTransaction: object['currentTransaction'],
              vehicles: decodeVehicleList(list: object['vehicles']),
              allVehicles: decodeVehicleList(list: object['allVehicles']),
              history: object['history'],
              createDate: object['createDate']);
        }).toList();

        return customerList;
      } else {
        log(name: "GetAll API:", "Response UnSuccessful");
      }
    } on Exception catch (e) {
      log(name: "GetAll API:", "$e");
    }

    return [];
  }

  static Future<Customer> createUser(String mobileNumber, String otp) async {
    Customer customer;
    log(name: "LOGIN USER API:", "CALLED");
    Map<String, dynamic> requestBody = {
      "mobileNumber": mobileNumber,
      "otp": otp
    };
    const url = "$defaultAPI/api/customer";
    Uri finalUrl = Uri.parse(url);
    try {
      var response = await client.post(finalUrl, body: requestBody);
      if (response.statusCode == 200) {
        log(name: "CREATE USER API:", "RESPONSE RECEIVED SUCCESSFULLY!");

        Map<dynamic, dynamic> data = json.decode(response.body);



        customer = Customer(
            mobileNumber: data['mobileNumber'],
            customerId: data['customerId'],
            balance: data['balance'],
            currentTransaction: data['currentTransaction'],
            vehicles: decodeVehicleList(list: data['vehicles']),
            allVehicles: decodeVehicleList(list: data['allVehicles']),
            history: data['history'],
            createDate: data['createDate']);

        log(name: "CREATE USER API:", "$customer");

        return customer;
      } else {
        log(
            name: "CREATE USER API:",
            "RESPONSE FAILED: ${response.statusCode}");
        throw "Something went wrong: ${response.statusCode}";
      }
    } on Exception catch (e) {
      log(name: "CREATE USER API:", "EXCEPTION OCCURRED: $e ");
      throw "Something went wrong.";
    }
  }

  //TODO UMM THESE TWO METHOD ARE SIMILAR, CAN OPTIMIZE CODE

  static Future<Customer> loginUser(
      String mobileNumber, String customerId) async {
    Customer customer;
    log(name: "LOGIN USER API:", "CALLED");
    Map<String, dynamic> requestBody = {
      "mobileNumber": mobileNumber,
      "customerId": customerId
    };
    const url = "$defaultAPI/api/customer";
    Uri finalUrl = Uri.parse(url);
    try {
      var response = await client.post(finalUrl, body: requestBody);
      if (response.statusCode == 200) {
        log(name: "LOGIN USER API:", "RESPONSE RECEIVED SUCCESSFULLY!");
        Map<dynamic, dynamic> data = json.decode(response.body);

        // todo umm failure pr bhi map aa rha hai , jisme status: failure hai. now agr login successful hai toh status naam se attribute hi nhi hai
        // OKAY GOT MY ANSWER: basically cust_id is not a password tht a user must remember, it will be stored uin cache memory!
        if (data.length == 2) {
          log(name: "LOGIN USER API:", "INVALID CREDENTIALS");
          throw "Invalid Credentials";
          // login failed due to invalid credential
        }

        // todo Make a global function for converting list of vehicles from dynamic to vehicle type
        List<dynamic> tempVehicleList = data['vehicles'];
        List<dynamic> tempAllVehicleList = data['allVehicles'];

        List<Vehicle> vehicleList = tempVehicleList.map((tempVehicle) {
          return Vehicle(
              vehicleNumber: tempVehicle['vehicleNumber'],
              vehicleType: tempVehicle['vehicleType'],
              date: tempVehicle['createDate']);
        }).toList();

        log(
            name: "Get Customer API:",
            "Vehicle list received :${vehicleList.length}");

        List<Vehicle> allVehicleList = tempAllVehicleList.map((tempVehicle) {
          return Vehicle(
              vehicleNumber: tempVehicle['vehicleNumber'],
              vehicleType: tempVehicle['vehicleType'],
              date: tempVehicle['createDate']);
        }).toList();

        log(
            name: "Get Customer API:",
            "AllVehicle list received :${allVehicleList.length}");

        customer = Customer(
            mobileNumber: data['mobileNumber'],
            customerId: data['customerId'],
            balance: data['balance'],
            currentTransaction: data['currentTransaction'],
            vehicles: vehicleList,
            allVehicles: allVehicleList,
            history: data['history'],
            createDate: data['createDate']);

        log(name: "LOGIN USER API:", "$customer");
        return customer;
      } else {
        log(name: "LOGIN USER API:", "RESPONSE FAILED: ${response.statusCode}");
        throw "Something went wrong: ${response.statusCode}";
      }
    } on Exception catch (e) {
      log(name: "LOGIN USER API:", "EXCEPTION OCCURRED: $e ");
      throw "Something went wrong.";
    }
  }

  static Future addVehicle(
      {required String mobileNumber,
      required String customerId,
      required String vehicleType,
      required String vehicleNumber}) async {
    Customer customer;
    const String url = "$defaultAPI/api/vehicle/add";
    Uri finalUrl = Uri.parse(url);

    Map<String, dynamic> request = {
      "mobileNumber": mobileNumber,
      "customerId": customerId,
      "vehicleType": vehicleType,
      "vehicleNumber": vehicleNumber
    };

    try {
      Response response = await client.post(finalUrl, body: request);
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = json.decode(response.body);

        if (data.length == 2) {
          throw "Operation failed";
        }

        List<dynamic> tempVehicleList = data['vehicles'];
        List<dynamic> tempAllVehicleList = data['allVehicles'];

        List<Vehicle> vehicleList = tempVehicleList.map((tempVehicle) {
          return Vehicle(
              vehicleNumber: tempVehicle['vehicleNumber'],
              vehicleType: tempVehicle['vehicleType'],
              date: tempVehicle['createDate']);
        }).toList();

        log(
            name: "Add Vehicle API",
            "Vehicle list received :${vehicleList.length}");

        List<Vehicle> allVehicleList = tempAllVehicleList.map((tempVehicle) {
          return Vehicle(
              vehicleNumber: tempVehicle['vehicleNumber'],
              vehicleType: tempVehicle['vehicleType'],
              date: tempVehicle['createDate']);
        }).toList();

        log(
            name: "Add Vehicle API",
            "AllVehicle list received :${allVehicleList.length}");

        customer = Customer(
            mobileNumber: data['mobileNumber'],
            customerId: data['customerId'],
            balance: data['balance'],
            currentTransaction: data['currentTransaction'],
            vehicles: vehicleList,
            allVehicles: allVehicleList,
            history: data['history'],
            createDate: data['createDate']);
      } else {
        throw "Response failed ${response.statusCode}";
      }
    } on Exception catch (e) {
      throw "Response failed";
    }

    return customer;
  }

  static Future<List<Vehicle>?> getCustomerAllVehicles(
      {required String customerNumber, required String customerId}) async {
    List<Vehicle>? list;
    try {
      Customer customer = await loginUser(customerNumber, customerId);
      list = customer.allVehicles;
    } on Exception catch (e) {
      log(name: "Get Customer All Vehicles", "Exception $e");
    }
    return list;
  }

  static Future createTransaction(
      {required Map<String, String> transactionBody}) async {
    // todo make a class that consist of all path
    // todo since user is logged in toh usska data toh preferences me haii

    Customer customer;
    String path = "$defaultAPI/api/transaction/create";
    Uri url = Uri.parse(path);

    Response response = await http.put(url, body: transactionBody);

    if (response.statusCode == 200) {
      Map<dynamic, dynamic> data = json.decode(response.body);

      if (data.length == 2) {
        throw "Transaction failed";
      }

      customer = Customer();
    } else {
      throw "Failed to load response";
    }
  }

  static List<Vehicle> decodeVehicleList({required List<dynamic> list}) {
    List<Vehicle> vehicleList = list.map((tempVehicle) {
      return Vehicle(
          vehicleNumber: tempVehicle['vehicleNumber'],
          vehicleType: tempVehicle['vehicleType'],
          date: tempVehicle['createDate']);
    }).toList();

    return vehicleList;

  }

  // todo doubt that what will
  // static List<Transaction> decodeHistory({required List<dynamic> list})
  // {
  //   List<Transaction> historyList = list.map((transaction){
  //     return Transaction(
  //       : transaction['mobileNumber']
  //
  //     );
  //   }).toList();
  // }


}
