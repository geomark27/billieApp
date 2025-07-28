/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: data
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/utils/create_model_from_map.dart';

class Data<T extends Mappable> {
  final bool requirePagination;
  final List<T> data;
  final bool invalidToken;

  Data({
    required this.requirePagination,
    required this.data,
    required this.invalidToken,
  });

  factory Data.fromJson(Map json, T Function(Map<String, dynamic>) fromJson) {
    return Data(
      requirePagination: json['require_pagination'] ?? false,
      data: createModelFromMap(
        json['data'],
        fromJson,
      ),
      invalidToken: json['invalid_token'] ?? false,
    );
  }
}
