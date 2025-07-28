/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_due_report
*/

import 'package:salepro/models/mappable.dart';

class CustomerDueReport implements Mappable {
  final String? startDate;
  final String? endDate;

  final String? date;
  final String? reference;
  final String? customer;
  final String? grandTotal;
  final String? returnedAmount;
  final String? paid;
  final String? due;

  CustomerDueReport({
    this.startDate,
    this.endDate,
    this.date,
    this.reference,
    this.customer,
    this.grandTotal,
    this.returnedAmount,
    this.paid,
    this.due,
  });

  factory CustomerDueReport.fromJson(Map json) {
    return CustomerDueReport(
      date: json['date'],
      reference: json['reference'],
      customer: json['customer'],
      grandTotal: json['grand_total'],
      returnedAmount: json['returned_amount'],
      paid: json['paid'],
      due: json['due'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      CustomerDueReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference': reference,
      'customer': customer,
      'grand_total': grandTotal,
      'returned_amount': returnedAmount,
      'paid': paid,
      'due': due,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
