/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: create_model_from_map
*/

import 'package:salepro/models/mappable.dart';

List<T> createModelFromMap<T extends Mappable>(
  List data,
  T Function(Map<String, dynamic>) fromJson,
) {
  return data.map((item) => fromJson(item)).toList();
}
