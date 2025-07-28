/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: currency
*/

import 'package:salepro/models/mappable.dart';

class Currency implements Mappable {
  final int id;
  final String name;
  final String code;
  final double exchangeRate;

  Currency(
      {required this.id,
      required this.name,
      required this.code,
      required this.exchangeRate});

  factory Currency.fromJson(Map json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      exchangeRate: double.tryParse(json['exchange_rate']) ?? 1.00,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Currency.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'exchange_rate': exchangeRate,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'code': code,
      'name': name,
      'exchange_rate': exchangeRate,
    };
  }
}
