/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: biller_report
*/

import 'package:salepro/models/data.dart';
import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_payment.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_sale.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_quotation.dart';

class BillerReport implements Mappable {
  final String? biller;
  final String? startDate;
  final String? endDate;

  final Data<BillerSaleReport>? sales;
  final Data<BillerPaymentReport>? payments;
  final Data<BillerQuotationReport>? quotations;

  BillerReport({
    this.biller,
    this.startDate,
    this.endDate,
    this.sales,
    this.payments,
    this.quotations,
  });

  factory BillerReport.fromJson(Map json) {
    return BillerReport(
      sales: Data.fromJson(
        json['biller_sales'],
        BillerSaleReport.fromJson,
      ),
      payments: Data.fromJson(
        json['biller_payments'],
        BillerPaymentReport.fromJson,
      ),
      quotations: Data.fromJson(
        json['biller_quotations'],
        BillerQuotationReport.fromJson,
      ),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => BillerReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'biller_id': biller,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
