import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleController extends GetxController{

  GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  GlobalKey<FormState> customerIdKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleTypeKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleNumberKey = GlobalKey<FormState>();


  TextEditingController mobileController = TextEditingController();
  TextEditingController customerIdController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();


}