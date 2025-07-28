/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: dashboard
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/dashboard.dart';

class DashboardAPI extends BaseAPI<DashboardData> {
  DashboardAPI() : super('dashboard');

  @override
  DashboardData fromJson(Map<String, dynamic> json) =>
      DashboardData.fromJson(json);

  static Future<DashboardData?> get(String? token) async {
    final api = DashboardAPI();
    return await api.SINGLE(token: token);
  }
}
