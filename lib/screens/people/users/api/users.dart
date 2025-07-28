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
  static Future<Data<User>> get(String? token,
      {int page = 1, String query = ''}) async {
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

  /// Crea un nuevo usuario con datos específicos para el formulario de agregar usuario.
  static Future<Message> create({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String roleId,
    bool isActive = true,
    String? token,
  }) async {
    final api = UsersAPI();

    // Crear objeto User temporal para envío (sin ID ya que es nuevo)
    final userData = User(
      id: 0, // ID temporal, será asignado por el servidor
      name: name,
      email: email,
      phoneNumber: phone,
      roleId: int.parse(roleId),
      billerId: 1, // Valor por defecto, puede ser ajustado según necesidades
      warehouseId: 1, // Valor por defecto, puede ser ajustado según necesidades
      isActive: isActive ? 1 : 0,
    );

    return await api.POST(data: userData, token: token);
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

  /// Obtiene un usuario específico por ID.
  static Future<User?> getById(int id, String? token) async {
    final api = UsersAPI();
    return await api.SINGLE(token: token);
  }
}
