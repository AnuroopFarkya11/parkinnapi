// ignore_for_file: unnecessary_getters_setters

/*
*
*            TRANSACTION MODAL
*
*
* */
import 'package:parkinnapi/Modals/vehicle_modal.dart';

class Transaction {
  late String? transactionId;
  late Vehicle? vehicleData;
  late DateTime? startTime;
  late DateTime? endTime;
  late String? locationId;
  late int? amount;
  late int? closingBalance;
  late DateTime? createDate;

  Transaction(
      {this.transactionId,
      this.vehicleData,
      this.startTime,
      this.endTime,
      this.locationId,
      this.amount,
      this.closingBalance,
      this.createDate});
}
