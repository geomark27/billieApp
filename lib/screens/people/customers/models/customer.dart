/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/settings/customers_groups/models/customer_group.dart';

class Customer implements Mappable {
  final int id;
  final bool? both;
  final String customerName;
  final String? companyName;
  final String? phoneNumber;
  final String? email;
  final String? taxNo;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final double? points;
  final double? deposit;
  final double? expense;
  final double? totalDue;
  final CustomerGroup? customerGroup;
  final bool? user;
  final String? name;
  final String? password;

  Customer({
    required this.id,
    required this.customerName,
    this.both,
    this.companyName,
    this.phoneNumber,
    this.email,
    this.taxNo,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.points,
    this.deposit,
    this.totalDue,
    this.expense,
    this.customerGroup,
    this.user,
    this.name,
    this.password,
  });

  factory Customer.fromJson(Map json) {
    return Customer(
      id: json['id'],
      customerName: json['name'],
      companyName: json['company_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      taxNo: json['tax_no'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      points: double.tryParse(json['points'].toString()) ?? 0,
      deposit: double.tryParse(json['deposit'].toString()) ?? 0,
      expense: double.tryParse(json['expense'].toString()) ?? 0,
      totalDue: double.tryParse(json['total_due'].toString()) ?? 0,
      customerGroup: json['customer_group'] != null
          ? CustomerGroup.fromJson(
              json['customer_group'],
            )
          : null,
      both: json['both'] ?? false,
      user: json['user'] != null,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Customer.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'customer_name': customerName,
      'company_name': companyName,
      'phone_number': phoneNumber,
      'email': email,
      'tax_no': taxNo,
      'address': address,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
      'points': points,
      'deposit': deposit,
      'expense': expense,
      'total_due': totalDue,
      'customer_group': customerGroup?.toMap(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'both': both,
      'customer_name': customerName,
      'company_name': companyName,
      'phone_number': phoneNumber,
      'email': email,
      'tax_no': taxNo,
      'address': address,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
      'customer_group_id': customerGroup?.id ?? 1,
      'user': user,
      'name': name,
      'password': password,
      'pos': 0,
    };
  }
}
