/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: income_category
*/

import 'package:salepro/models/mappable.dart';

class IncomeCategory implements Mappable {
  final int id;
  final String name;
  final String code;
  final bool isActive;

  IncomeCategory({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
  });

  factory IncomeCategory.fromJson(Map json) {
    return IncomeCategory(
      id: json['id'] ?? 0,
      name: json['name'],
      code: json['code'],
      isActive: json['is_active'] ?? true,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => IncomeCategory.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'is_active': isActive,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'code': code,
      'is_active': isActive,
    };
  }
}
