/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: unit
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/units/models/unit.dart';

class UnitAPI extends BaseAPI<Unit> {
  UnitAPI() : super("units");

  @override
  Unit fromJson(Map<String, dynamic> json) => Unit.fromJson(json);

  static Future<Data<Unit>> get(String? token) async {
    final api = UnitAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(Unit unit, String? token) async {
    final api = UnitAPI();
    return await api.POST(
      data: unit,
      token: token,
    );
  }

  static Future<Message> update(int id, Unit unit, String? token) async {
    final api = UnitAPI();
    return await api.PUT(
      id: id,
      data: unit,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = UnitAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
