import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salepro/api/client.dart';
import 'package:salepro/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getRegistrationFormData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiUrl   = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;
  String spToken  = prefs.getString(AppKeys.saleproSetupToken) ?? "";

  final response = await http
      .get(Uri.parse("$apiUrl/get-registration-form-data?token=$spToken"));
  if (response.statusCode == 200) {
    final Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  } else {
    return {
      'roles': [],
      'customer_groups': [],
      'billers': [],
      'warehouses': [],
    };
  }
}

Future<Map<String, dynamic>> getRolesForUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiUrl   = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;
  String spToken  = prefs.getString(AppKeys.saleproSetupToken) ?? "";

  final response = await http
    .get(Uri.parse("$apiUrl/get-roles?token=$spToken"));
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  } else {
    return {
      'roles': [],
    };
  }
}
