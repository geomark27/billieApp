/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: users
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/models/user.dart';

class UsersAPI extends BaseAPI<User> {
  UsersAPI() : super('users');

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);

  // --- MÉTODOS COMPLETOS Y CORREGIDOS PARA EL ENFOQUE MANUAL ---

  /// Obtiene una lista de usuarios, con soporte para paginación y búsqueda.
  static Future<Data<User>> get(String? token, {int page = 1, String query = ''}) async {
    final api = UsersAPI();
    
    // Prepara los parámetros de búsqueda si existen
    final searchParams = <String, String>{};
    if (query.isNotEmpty) {
      searchParams['search'] = query;
    }

    // Llama al método GET de la clase base, pasando todos los parámetros
    return await api.GET(
      token: token,
      count: page,
      searchParams: searchParams,
    );
  }

  /// Crea un nuevo usuario.
  static Future<Message> create(User user, String? token) async {
    final api = UsersAPI();
    return await api.POST(data: user, token: token);
  }

  /// Actualiza un usuario existente.
  static Future<Message> update(int id, User user, String? token) async {
    final api = UsersAPI();
    return await api.PUT(id: id, data: user, token: token);
  }

  /// Elimina un usuario.
  static Future<Message> delete(int id, String? token) async {
    final api = UsersAPI();
    return await api.DELETE(id: id, token: token);
  }
}