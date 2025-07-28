/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier
*/

import 'package:salepro/models/mappable.dart';

class Supplier implements Mappable {
  final int id;
  final String name;
  final String? image;
  final String? companyName;
  final String? vatNumber;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? totalDue;

  Supplier({
    required this.id,
    required this.name,
    this.image,
    this.companyName,
    this.vatNumber,
    this.email,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.totalDue,
  });

  factory Supplier.fromJson(Map json) {
    return Supplier(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      companyName: json['company_name'],
      vatNumber: json['vat_number'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      totalDue: json['total_due'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Supplier.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'company_name': companyName,
      'vat_number': vatNumber,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
      'total_due': totalDue,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'company_name': companyName,
      'vat_number': vatNumber,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
    };
  }
}
