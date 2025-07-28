/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_group_report
*/

import 'package:salepro/models/data.dart';
import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_payment.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_sale.dart';

class CustomerGroupReport implements Mappable {
  final String? customerGroup;
  final String? startDate;
  final String? endDate;

  final Data<CustomerGroupSaleReport>? sales;
  final Data<CustomerGroupPaymentReport>? payments;

  CustomerGroupReport({
    this.customerGroup,
    this.startDate,
    this.endDate,
    this.sales,
    this.payments,
  });

  factory CustomerGroupReport.fromJson(Map json) {
    return CustomerGroupReport(
      sales: Data.fromJson(
        json['customer_group_sales'],
        CustomerGroupSaleReport.fromJson,
      ),
      payments: Data.fromJson(
        json['customer_group_payments'],
        CustomerGroupPaymentReport.fromJson,
      ),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      CustomerGroupReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'customer_group_id': customerGroup,
      'starting_date': startDate,
      'ending_date': endDate,
    };
  }
}
