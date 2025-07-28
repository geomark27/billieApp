/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: biller
*/

import 'package:salepro/models/mappable.dart';

class Biller implements Mappable {
  final int id;
  final String name;
  final String? image;
  final String companyName;
  final String? vatNumber;
  final String email;
  final String phoneNumber;
  final String address;
  final String city;
  final String? state;
  final String? postalCode;
  final String? country;

  Biller(
      {required this.id,
      required this.name,
      this.image,
      required this.companyName,
      this.vatNumber,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.city,
      this.state,
      this.postalCode,
      this.country});

  factory Biller.fromJson(Map json) {
    return Biller(
      id: json['id'],
      name: json['name'] ?? "No Name",
      image: json['image'],
      companyName: json['company_name'] ?? "No Company",
      vatNumber: json['vat_number'],
      email: json['email'] ?? "No Email",
      phoneNumber: json['phone_number'] ?? "No Phone",
      address: json['address'] ?? "No Address",
      city: json['city'] ?? "No City",
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Biller.fromJson(json);

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
