/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_groups
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/customers_groups/models/customer_group.dart';

class CustomerGroupAPI extends BaseAPI<CustomerGroup> {
  CustomerGroupAPI() : super('customergroups');

  @override
  CustomerGroup fromJson(Map<String, dynamic> json) =>
      CustomerGroup.fromJson(json);

  static Future<Data<CustomerGroup>> get(String? token) async {
    final api = CustomerGroupAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    CustomerGroup customerGroup,
    String? token,
  ) async {
    final api = CustomerGroupAPI();
    return await api.POST(data: customerGroup, token: token);
  }

  static Future<Message> update(
      int id, CustomerGroup customerGroup, String? token) async {
    final api = CustomerGroupAPI();
    return await api.PUT(id: id, data: customerGroup, token: token);
  }

  static Future<Message> delete(int id, String? token) async {
    final api = CustomerGroupAPI();
    return await api.DELETE(id: id, token: token);
  }
}
