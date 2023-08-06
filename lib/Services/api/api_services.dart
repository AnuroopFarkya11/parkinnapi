import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../Modals/customer_modal.dart';
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
          List<dynamic> tempVehicleList = object['vehicles'];
          List<dynamic> tempAllVehicleList = object['allVehicles'];

          vehicleList = tempVehicleList.map((tempVehicle) {
            return Vehicle(
                vehicleNumber: tempVehicle['vehicleNumber'],
                vehicleType: tempVehicle['vehicleType'],
                date: tempVehicle['createDate']);
          }).toList();
          log(
              name: "GetAll API:",
              "Vehicle list received :${vehicleList.length}");

          allVehicleList = tempAllVehicleList.map((tempVehicle) {
            return Vehicle(
                vehicleNumber: tempVehicle['vehicleNumber'],
                vehicleType: tempVehicle['vehicleType'],
                date: tempVehicle['createDate']);
          }).toList();

          log(
              name: "GetAll API:",
              "AllVehicle list received :${allVehicleList.length}");

          // object['vehicle']
          return Customer(
              mobileNumber: object['mobileNumber'],
              customerId: object['customerId'],
              balance: object['balance'],
              currentTransaction: object['currentTransaction'],
              vehicles: vehicleList,
              allVehicles: allVehicleList,
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
    Map<String, dynamic> requestBody = {"mobileNumber": mobileNumber, "otp": otp};
    const url = "$defaultAPI/api/customer";
    Uri finalUrl = Uri.parse(url);
    try {
      var response = await client.post(finalUrl, body: requestBody);
      if (response.statusCode == 200) {

        log(name: "LOGIN USER API:", "RESPONSE RECEIVED SUCCESSFULLY!");
        Map<dynamic, dynamic> data = json.decode(response.body);

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
  //TODO UMM THESE TWO METHOD ARE SIMILAR, CAN OPTIMIZE CODE

  static Future<Customer> loginUser(String mobileNumber, String customerId) async {
    Customer customer;
    log(name: "LOGIN USER API:", "CALLED");
    Map<String, dynamic> requestBody = {"mobileNumber": mobileNumber, "customerId": customerId};
    const url = "$defaultAPI/api/customer";
    Uri finalUrl = Uri.parse(url);
    try {
      var response = await client.post(finalUrl, body: requestBody);
      if (response.statusCode == 200) {

        log(name: "LOGIN USER API:", "RESPONSE RECEIVED SUCCESSFULLY!");
        Map<dynamic, dynamic> data = json.decode(response.body);

        // todo umm failure pr bhi map aa rha hai , jisme status: failure hai. now agr login successful hai toh status naam se attribute hi nhi hai
        // OKAY GOT MY ANSWER: basically cust_id is not a password tht a user must remember, it will be stored uin cache memory!
        if(data.length==2)
          {
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

  static Future addVehicle(String mobileNumber, String customerId, String vehicleType, String vehicleNumber) async{

    const String url = "$defaultAPI/api/vehicle/add";
    Uri finalUrl = Uri.parse(url);

    Map<String,dynamic> request = {
      "mobileNumber":"7174",
      "customerId":"zEZI}ZKAG7",
      "vehicleType":"2W",
      "vehicleNumber":"KA 02 KM 1212"
    };

    try {
      var response = await client.put(finalUrl,body: request);
      if(response.statusCode==200)
        {
          var customer = json.decode(response.body);


        }
      else{

      }


    } on Exception catch (e) {
      // TODO
    }



  }

  

}
