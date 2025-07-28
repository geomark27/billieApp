/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: role
*/

import 'package:salepro/models/mappable.dart';

class Role implements Mappable {
  final int id;
  final String name;
  final String? description;
  final int warehouseRequired;
  final int billerRequired;
  final int customerDetailsRequired;

  Role({
    required this.id,
    required this.name,
    this.description,
    this.warehouseRequired = 0,
    this.billerRequired = 0,
    this.customerDetailsRequired = 0,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      warehouseRequired: json['warehouse_required'],
      billerRequired: json['biller_required'],
      customerDetailsRequired: json['customer_details_required'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Role.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'warehouse_required': warehouseRequired,
      'biller_required': billerRequired,
      'customer_details_required': customerDetailsRequired,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'description': description,
      'warehouse_required': warehouseRequired,
      'biller_required': billerRequired,
      'customer_details_required': customerDetailsRequired,
    };
  }
}
