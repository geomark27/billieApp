/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_report
*/

import 'package:salepro/models/data.dart';
import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_payment.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_sale.dart';

class CustomerReport implements Mappable {
  final String? customer;
  final String? startDate;
  final String? endDate;

  final Data<CustomerSaleReport>? sales;
  final Data<CustomerPaymentReport>? payments;

  CustomerReport({
    this.customer,
    this.startDate,
    this.endDate,
    this.sales,
    this.payments,
  });

  factory CustomerReport.fromJson(Map json) {
    return CustomerReport(
      sales: Data.fromJson(
        json['customer_sales'],
        CustomerSaleReport.fromJson,
      ),
      payments: Data.fromJson(
        json['customer_payments'],
        CustomerPaymentReport.fromJson,
      ),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => CustomerReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'customer_id': customer,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
