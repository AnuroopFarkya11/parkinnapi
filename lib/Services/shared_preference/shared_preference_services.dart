import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedService{
  static SharedPreferences? shared;
  static String? userId = null;
  static String? userNumber = null;

  // do remember always first call this method
  static Future initializePreferences()async{
    log(name: "SHARED SERVICE","INITIALIZATION CALLED");
    try {
      shared = await SharedPreferences.getInstance();
    } on Exception catch (e) {
      log(name: "SHARED SERVICE","EXCEPTION CAUSED : $e");

    }
  }

  static Map<String?,String?>? getCustomerData()
  {
    // String? userId;
    // String? userNumber;
    Map<String?,String?>? userCredential;
    try {
      userId = shared!.getString('customerId');
      userNumber = shared!.getString('customerNumber');
          userCredential = {
            "userId":userId,
            "userNumber": userNumber,};


          log(name: "SHARED SERVICE","CUSTOMER ID RETRIEVED");

      return userCredential;

    } on Exception catch (e) {
      log(name: "SHARED SERVICE","CUSTOMER ID FAILED $e");

    }

    return null;
  }

  static void setCustomerId(String customerNumber, String customerId)
  {
    try {
      shared!.setString("customerId", customerId);
      shared!.setString("customerNumber", customerNumber);
      log(name: "SHARED SERVICE","CUSTOMER ID & NUMBER SET SUCCESSFULLY");

    } on Exception catch (e) {
      log(name: "SHARED SERVICE","CUSTOMER ID AND NUMBER SET FAILED");
    }
  }

  static void setStatus({bool status = false}){

    try {
      shared!.setBool('LogStatus', status);
      log(name: "SHARED SERVICE","STATUS SET: $status");

    } on Exception catch (e) {
      log(name: "SHARED SERVICE","STATUS SET: FAILED $e");
    }

  }
  static bool? checkStatus(){

    bool? status = false;
    try {

      status = shared!.getBool('LogStatus');
      log(name: "SHARED SERVICE","LOG STATUS : $status");
    } on Exception catch (e) {
      log(name: "SHARED SERVICE","LOG STATUS FAILED $e");
    }


    return status;

  }




}