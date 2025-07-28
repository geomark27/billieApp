/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_report
*/

import 'package:salepro/models/data.dart';
import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_payment.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_purchase.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_quotation.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_return.dart';

class SupplierReport implements Mappable {
  final String? supplier;
  final String? startDate;
  final String? endDate;

  final Data<SupplierPurchaseReport>? purchases;
  final Data<SupplierPaymentReport>? payments;
  final Data<SupplierReturnReport>? returns;
  final Data<SupplierQuotationReport>? quotations;

  SupplierReport({
    this.supplier,
    this.startDate,
    this.endDate,
    this.purchases,
    this.payments,
    this.returns,
    this.quotations,
  });

  factory SupplierReport.fromJson(Map json) {
    return SupplierReport(
      purchases: Data.fromJson(
        json['supplier_purchases'],
        SupplierPurchaseReport.fromJson,
      ),
      payments: Data.fromJson(
        json['supplier_payments'],
        SupplierPaymentReport.fromJson,
      ),
      returns: Data.fromJson(
        json['supplier_returns'],
        SupplierReturnReport.fromJson,
      ),
      quotations: Data.fromJson(
        json['supplier_quotations'],
        SupplierQuotationReport.fromJson,
      ),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => SupplierReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'supplier_id': supplier,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
