/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: auth
*/

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salepro/api/client.dart';
import 'package:salepro/constants/keys.dart';
import 'package:salepro/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Message> setup(Map<String, dynamic> config) async {
	final response = await http.post(
		Uri.parse("${config['install_url']}/api/check"),
		body: config
	);
	if (response.statusCode == 200) {
		try {
			final body = jsonDecode(response.body);
			Message message = Message.fromJson(body);

			if (message.data != null && message.data!['token'] != null) {
				final SharedPreferences prefs = await SharedPreferences.getInstance();
				prefs.setString(
					AppKeys.saleproInstallURL, "${config['install_url']}/api");
				prefs.setString(AppKeys.saleproSetupToken, message.data!['token']);
				return message;
			} else {
				return message;
			}
		} catch (e) {
			return Message.fromJson(
				{
				'success': false,
				'message': "Invalid Installation URL...",
				},
			);
		}
	} else {
		try {
			final body = jsonDecode(response.body);
			return Message.fromJson(body);
		} catch (e) {
			return Message.fromJson(
				{
				'success': false,
				'message': "Invalid Installation URL...",
				},
			);
		}
	}
}

Future<Message> register(Map<String, dynamic> userData) async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();
	String apiUrl = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;
	String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

	final response = await http.post(
		Uri.parse("$apiUrl/register?token=$spToken"),
		body: userData,
	);
	if (response.statusCode == 200) {
		final body = jsonDecode(response.body);
		Message message = Message.fromJson(body);

		if (message.data != null && message.data!['token'] != null) {
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString(AppKeys.loginKey, message.data!['token']);
			return message;
		} else {
			return message;
		}
	} else {
		final body = jsonDecode(response.body);
		if (body['invalid_token'] != null && body['invalid_token']) {
			prefs.clear();
		}
		return Message.fromJson(body);
	}
}

Future<Message> login(Map<String, dynamic> userData) async {
	final SharedPreferences prefs = await SharedPreferences.getInstance();
	String apiUrl = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;
	String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

	final url = Uri.parse("$apiUrl/login?token=$spToken");

	// ✅ PASO 1: AÑADE LOGS AQUÍ
	print('--- Iniciando Petición de Login ---');
	print('URL: $url');
	print('Token: $spToken');
	print('Body: $userData');

	final response = await http.post(
		url,
		body: userData,
	);

	// ✅ PASO 2: AÑADE LOGS DE LA RESPUESTA
	print('Status Code: ${response.statusCode}');
	print('Response Body: ${response.body}');
	print('--- Fin de la Petición ---');

	if (response.statusCode == 200) {
		final body = jsonDecode(response.body);
		Message message = Message.fromJson(body);

		if (message.data != null && message.data!['token'] != null) {
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			prefs.setString(AppKeys.loginKey, message.data!['token']);
			return message;
		} else {
			return message;
		}
	} else {
		final body = jsonDecode(response.body);
		if (body['invalid_token'] != null && body['invalid_token']) {
			prefs.clear();
		}
		return Message.fromJson(body);
	}
}

Future<Map<String, dynamic>> verifyToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String apiUrl = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;

  if (token.isEmpty) {
    print('Token vacío al llamar a verifyToken');
    return {'success': false, 'message': 'Token vacío'};
  }

  final String fullUrl = "$apiUrl/get-user";
  print('🛰 Haciendo petición a: $fullUrl');
  print('🔐 Token enviado: $token');

  final response = await http.get(
    Uri.parse(fullUrl),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  print('📡 Status code recibido: ${response.statusCode}');
  print('📦 Respuesta body: ${response.body}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {...data, 'success': true};
  } else {
    final data = jsonDecode(response.body);
    if (data['invalid_token'] == true) {
      await prefs.clear();
    }
    return {...data, 'success': false};
  }
}

