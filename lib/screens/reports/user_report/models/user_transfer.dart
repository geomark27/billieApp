/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_transfer
*/

import 'package:salepro/models/mappable.dart';

class UserTransferReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? from;
  final String? to;
  final String? product;
  final String? grandTotal;
  final String? status;

  UserTransferReport({
    this.date,
    this.referenceNo,
    this.from,
    this.to,
    this.product,
    this.grandTotal,
    this.status,
  });

  factory UserTransferReport.fromJson(Map json) {
    return UserTransferReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      from: json['from'],
      to: json['to'],
      product: json['product'],
      grandTotal: json['grand_total'],
      status: json['status'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      UserTransferReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'from': from,
      'to': to,
      'product': product,
      'grand_total': grandTotal,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
