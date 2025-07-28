/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: mappable
*/

abstract class Mappable {
  Mappable fromJson(Map<String, dynamic> json) => throw UnimplementedError();
  Map<String, dynamic> toMap();
  Map<String, dynamic> toFormData();
}
