/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: challan_report
*/

import 'package:salepro/models/mappable.dart';

class ChallanReport implements Mappable {
  final String? basedOn;
  final String? startDate;
  final String? endDate;

  final String? challanNo;
  final String? orderNo;
  final String? orderDate;
  final String? code;
  final String? deliveryDate;
  final String? salesAmount;
  final String? cashPayment;
  final String? onlinePayment;
  final String? chequePayment;
  final String? shippingIncome;
  final String? deliveryCharge;
  final String? net;
  final String? netCash;

  ChallanReport({
    this.basedOn,
    this.startDate,
    this.endDate,
    this.challanNo,
    this.orderNo,
    this.orderDate,
    this.code,
    this.deliveryDate,
    this.salesAmount,
    this.cashPayment,
    this.onlinePayment,
    this.chequePayment,
    this.shippingIncome,
    this.deliveryCharge,
    this.net,
    this.netCash,
  });

  factory ChallanReport.fromJson(Map json) {
    return ChallanReport(
      challanNo: json['challan_no'],
      orderNo: json['order_no'],
      orderDate: json['order_date'],
      code: json['code'],
      deliveryDate: json['delivery_date'],
      salesAmount: json['sales_amount'],
      cashPayment: json['cash_payment'],
      onlinePayment: json['online_payment'].toString(),
      chequePayment: json['cheque_payment'].toString(),
      shippingIncome: json['shipping_income'].toString(),
      deliveryCharge: json['delivery_charge'],
      net: json['net'],
      netCash: json['net_cash'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => ChallanReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'challan_no': challanNo,
      'order_no': orderNo,
      'order_date': orderDate,
      'code': code,
      'delivery_date': deliveryDate,
      'sales_amount': salesAmount,
      'cash_payment': cashPayment,
      'online_payment': onlinePayment,
      'cheque_payment': chequePayment,
      'shipping_income': shippingIncome,
      'delivery_charge': deliveryCharge,
      'net': net,
      'net_cash': netCash,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'based_on': basedOn,
      'starting_date': startDate,
      'ending_date': endDate,
    };
  }
}
