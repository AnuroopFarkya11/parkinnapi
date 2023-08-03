import 'dart:developer';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://aquamarine-turkey-gear.cyclic.cloud';
class API {
  var client = http.Client();

  Future<dynamic> get (String api) async{
    var url = Uri.parse(baseUrl + api);

    var _headers = {

    };
    //getting response from get

    var response = await client.get(url);

    // if response is successfull statuscode = 200 shows it is successfull always use this in practice

    if (response.statusCode == 200){
      log(response.body);
    }
    else{
      //throw exception and catch it in UI
    }
  }
  Future<dynamic> post (String api) async{}
  Future<dynamic> put (String api) async{}
  Future<dynamic> delete (String api) async{}
}
