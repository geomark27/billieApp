/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/screens/reports/user_report/models/user_report.dart';

class UserReportAPI extends BaseAPI<UserReport> {
  UserReportAPI() : super('report/user-report');

  @override
  UserReport fromJson(Map<String, dynamic> json) => UserReport.fromJson(json);

  static Future<UserReport?> create(UserReport userReport,
      {String? token, int? count}) async {
    final api = UserReportAPI();
    return await api.POSTFORSINGLEDATA(
      data: userReport,
      token: token,
      count: count,
    );
  }
}
