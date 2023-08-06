// ignore_for_file: unnecessary_getters_setters

class Vehicle{

  //        VEHICLE PROPERTIES
  late String vehicleType;
  late String vehicleNumber;
  late String date;


/*  Vehicle()
  {
    _vehicleNumber ="DEFAULT NUMBER";
    _vehicleType = "DEFAULT TYPE";
    _date =  DateTime.now();
  }
  */
  Vehicle({
    required this.date,
    required this.vehicleNumber,
    required this.vehicleType

});



  //           SETTERS
  set setVehicleType(String value) {
    vehicleType = value;
  }


  set setVehicleNumber(String value) {
    vehicleNumber = value;
  }

  set setDate(String value) {
    date = value;
  }

  //            GETTERS

  String get gteVehicleType => vehicleType;

  String get getVehicleNumber => vehicleNumber;

  // DateTime get getDate => date;
  String get getDate => date;

  toJSON(){
    return{
    "vehicleType":vehicleType,
    "vehicleNumber":vehicleNumber,
    "date":date
    };
  }
}