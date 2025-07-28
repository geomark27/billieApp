/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: message
*/

class Message {
  final bool success;
  final String message;
  final Map<String, dynamic>? errors;
  final dynamic data;
  final bool invalidToken;

  Message({
    required this.success,
    required this.message,
    required this.invalidToken,
    this.errors,
    this.data,
  });

  factory Message.fromJson(Map json) {
    return Message(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      errors: json['errors'],
      data: json['data'],
      invalidToken: json['invalid_token'] ?? false,
    );
  }
}
