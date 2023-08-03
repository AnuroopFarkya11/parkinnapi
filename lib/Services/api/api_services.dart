import 'dart:developer';
import 'package:http/http.dart' as http;



class API {

  static http.Client client = http.Client();
  static const String defaultAPI =
      "https://aquamarine-turkey-gear.cyclic.cloud/";

  // this is a get method will be used to get the list of all the customers
  static Future<dynamic> getAllCustomers() async{
    String allCustomer = "https://aquamarine-turkey-gear.cyclic.cloud/api/customer/getAll";

    Uri url = Uri.parse(allCustomer);
    try {
      var response = await client.get(url);

      if(response.statusCode == 200)
        {
          log(name: "Get all customers:","Response Successful");
          log(name: "Get all customers:","${response.body}");

        }
      else{
        log(name: "Get all customers:","Response UnSuccessful");
      }
    } on Exception catch (e) {
      log(name: "Get all customers:", "$e");
    }


  }







}
