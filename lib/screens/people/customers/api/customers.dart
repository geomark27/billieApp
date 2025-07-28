/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customers
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';

class CustomerAPI extends BaseAPI<Customer> {
  CustomerAPI() : super('customers');

  @override
  Customer fromJson(Map<String, dynamic> json) => Customer.fromJson(json);

  static Future<Data<Customer>> get(String? token, [int count = 1]) async {
    final api = CustomerAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    Customer customer,
    String? token,
  ) async {
    final api = CustomerAPI();
    return await api.POST(
      data: customer,
      token: token,
    );
  }

  static Future<Message> update(
      int id, Customer customer, String? token) async {
    final api = CustomerAPI();
    return await api.PUT(
      id: id,
      data: customer,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = CustomerAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
