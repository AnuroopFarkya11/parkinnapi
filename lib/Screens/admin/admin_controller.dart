import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminController extends GetxController{

  TextEditingController adminIdController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();

  GlobalKey<FormState> adminId = GlobalKey<FormState>();
  GlobalKey<FormState> adminPassword = GlobalKey<FormState>();
  GlobalKey<FormState> mobileNumber = GlobalKey<FormState>();
  GlobalKey<FormState> transactionId = GlobalKey<FormState>();
}