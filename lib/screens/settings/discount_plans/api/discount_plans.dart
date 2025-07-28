/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: discount_plans
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/discount_plans/models/discount_plan.dart';

class DiscountPlansAPI extends BaseAPI<DiscountPlan> {
  DiscountPlansAPI() : super('discount-plans');

  @override
  DiscountPlan fromJson(Map<String, dynamic> json) =>
      DiscountPlan.fromJson(json);

  static Future<Data<DiscountPlan>> get(String? token) async {
    final api = DiscountPlansAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    DiscountPlan discountPlan,
    String? token, {
    Map<String, String>? fileData,
  }) async {
    final api = DiscountPlansAPI();
    return await api.POST(
      data: discountPlan,
      token: token,
      fileData: fileData,
    );
  }

  static Future<Message> update(
      int id, DiscountPlan discountPlan, String? token) async {
    final api = DiscountPlansAPI();
    return await api.PUT(
      id: id,
      data: discountPlan,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = DiscountPlansAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
