/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_due_report
*/

import 'package:salepro/models/mappable.dart';

class SupplierDueReport implements Mappable {
  final String? startDate;
  final String? endDate;

  final String? date;
  final String? reference;
  final String? supplier;
  final String? grandTotal;
  final String? returnedAmount;
  final String? paid;
  final String? due;

  SupplierDueReport({
    this.startDate,
    this.endDate,
    this.date,
    this.reference,
    this.supplier,
    this.grandTotal,
    this.returnedAmount,
    this.paid,
    this.due,
  });

  factory SupplierDueReport.fromJson(Map json) {
    return SupplierDueReport(
      date: json['date'],
      reference: json['reference'],
      supplier: json['supplier_details'],
      grandTotal: json['grand_total'],
      returnedAmount: json['return_amount'],
      paid: json['paid'],
      due: json['due'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      SupplierDueReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference': reference,
      'supplier': supplier,
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
