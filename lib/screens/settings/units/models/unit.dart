/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: unit
*/

import 'package:salepro/models/mappable.dart';

class Unit implements Mappable {
  final int id;
  final String code;
  final String name;
  final int? baseUnitId;
  final Unit? baseUnit;
  final String operator;
  final int operationValue;

  Unit({
    required this.id,
    required this.code,
    required this.name,
    this.baseUnit,
    this.baseUnitId,
    this.operator = "*",
    this.operationValue = 1,
  });

  factory Unit.fromJson(Map json) {
    return Unit(
      id: json['id'],
      code: json['unit_code'],
      name: json['unit_name'],
      baseUnit:
          json['base_unit'] != null ? Unit.fromJson(json['base_unit']) : null,
      baseUnitId: json['base_unit'] != null
          ? Unit.fromJson(json['base_unit']).id
          : null,
      operator: json['operator'],
      operationValue: json['operation_value'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Unit.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit_code': code,
      'unit_name': name,
      'base_unit': baseUnitId,
      'operator': operator,
      'operation_value': operationValue,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'unit_code': code,
      'unit_name': name,
      'base_unit': baseUnitId,
      'operator': operator,
      'operation_value': operationValue,
    };
  }
}
