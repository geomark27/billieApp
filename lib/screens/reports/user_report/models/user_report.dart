/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_report
*/

import 'package:salepro/models/data.dart';
import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/reports/user_report/models/user_expense.dart';
import 'package:salepro/screens/reports/user_report/models/user_payment.dart';
import 'package:salepro/screens/reports/user_report/models/user_payroll.dart';
import 'package:salepro/screens/reports/user_report/models/user_purchase.dart';
import 'package:salepro/screens/reports/user_report/models/user_quotation.dart';
import 'package:salepro/screens/reports/user_report/models/user_sale.dart';
import 'package:salepro/screens/reports/user_report/models/user_transfer.dart';

class UserReport implements Mappable {
  final String? user;
  final String? startDate;
  final String? endDate;

  final Data<UserSaleReport>? sales;
  final Data<UserPurchaseReport>? purchases;
  final Data<UserQuotationReport>? quotations;
  final Data<UserTransferReport>? transfers;
  final Data<UserPayrollReport>? payrolls;
  final Data<UserPaymentReport>? payments;
  final Data<UserExpenseReport>? expenses;

  UserReport({
    this.user,
    this.startDate,
    this.endDate,
    this.purchases,
    this.transfers,
    this.payrolls,
    this.payments,
    this.sales,
    this.quotations,
    this.expenses,
  });

  factory UserReport.fromJson(Map json) {
    return UserReport(
      purchases: Data.fromJson(
        json['user_purchases'],
        UserPurchaseReport.fromJson,
      ),
      payments: Data.fromJson(
        json['user_payments'],
        UserPaymentReport.fromJson,
      ),
      transfers: Data.fromJson(
        json['user_transfers'],
        UserTransferReport.fromJson,
      ),
      payrolls: Data.fromJson(
        json['user_payrolls'],
        UserPayrollReport.fromJson,
      ),
      sales: Data.fromJson(
        json['user_sales'],
        UserSaleReport.fromJson,
      ),
      quotations: Data.fromJson(
        json['user_quotations'],
        UserQuotationReport.fromJson,
      ),
      expenses: Data.fromJson(
        json['user_expenses'],
        UserExpenseReport.fromJson,
      ),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => UserReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'user_id': user,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
