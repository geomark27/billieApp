import 'package:salepro/models/mappable.dart';

class User implements Mappable {
  final int id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? companyName;
  final int roleId;
  final int billerId;
  final int warehouseId;
  int isActive; // <-- PROPIEDAD CLAVE: quitamos 'final' para poder modificarla

  User({
    required this.id,
    required this.name,
    required this.email,
    this.companyName,
    this.phoneNumber,
    required this.roleId,
    required this.billerId,
    required this.warehouseId,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      companyName: json['company_name'],
      email: json['email'] ?? '',
      phoneNumber: json['phone'],
      roleId: json['role_id'] ?? 0,
      billerId: json['biller_id'] ?? 0,
      warehouseId: json['warehouse_id'] ?? 0,
      isActive: json['is_active'] ?? 0,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'company_name': companyName,
      'email': email,
      'phone': phoneNumber,
      'role_id': roleId,
      'biller_id': billerId,
      'warehouse_id': warehouseId,
      'is_active': isActive,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return toMap();
  }
}