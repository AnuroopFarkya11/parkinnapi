import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class LoginController extends GetxController{
  GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  GlobalKey<FormState> customerIdKey = GlobalKey<FormState>();

  TextEditingController mobileController = TextEditingController();
  TextEditingController customerIdController = TextEditingController();


}