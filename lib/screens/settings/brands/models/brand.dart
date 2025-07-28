/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: brand
*/

import 'package:salepro/models/mappable.dart';

class Brand implements Mappable {
  final int id;
  final String title;
  final String? image;

  Brand({
    required this.id,
    required this.title,
    this.image,
  });

  factory Brand.fromJson(Map json) {
    return Brand(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Brand.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'title': title,
    };
  }
}
