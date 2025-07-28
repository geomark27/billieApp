/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: tax
*/

import 'package:salepro/models/mappable.dart';

class Tax implements Mappable {
  final int id;
  final String name;
  final int rate;

  Tax({required this.id, required this.name, required this.rate});

  factory Tax.fromJson(Map json) {
    return Tax(
      id: json["id"],
      name: json["name"],
      rate: json["rate"],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Tax.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rate': rate,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'rate': rate,
    };
  }
}
