/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_group
*/

import 'package:salepro/models/mappable.dart';

class CustomerGroup implements Mappable {
  final int id;
  final String name;
  final String percentage;

  CustomerGroup(
      {required this.id, required this.name, required this.percentage});

  factory CustomerGroup.fromJson(Map json) {
    return CustomerGroup(
      id: json["id"],
      name: json["name"],
      percentage: json["percentage"],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => CustomerGroup.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'percentage': percentage,
    };
  }
}
