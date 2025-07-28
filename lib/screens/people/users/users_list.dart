import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/models/user.dart';
import 'package:salepro/screens/people/users/api/users.dart';
import 'package:salepro/screens/people/users/add_user.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  // --- Estado del Widget ---
  bool _isLoading = true;
  List<User> _users = [];
  String? _errorMessage;
  int? _expandedUserId;

  // --- Variables para Paginación ---
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  
  // --- Variables para Búsqueda ---
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // 1. Carga la primera página de usuarios cuando la pantalla se inicia.
    _fetchUsers();

    // 2. Escucha los eventos de scroll para cargar más usuarios.
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 200 &&
          _hasNextPage &&
          !_isLoadMoreRunning) {
        _loadMoreUsers();
      }
    });
  }
  
  // Limpia los controladores para evitar fugas de memoria.
  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Carga la PRIMERA página de usuarios y maneja las nuevas búsquedas.
  Future<void> _fetchUsers({bool isSearching = false}) async {
    // Si es una nueva búsqueda, resetea el estado para mostrar resultados limpios.
    if (isSearching) {
      setState(() {
        _isLoading = true;
        _users = [];
        _currentPage = 1;
        _hasNextPage = true;
        _expandedUserId = null;
      });
    }

    final token = Provider.of<CommonDataProvider>(context, listen: false).token;
    if (token == null) {
      if (mounted) setState(() => _errorMessage = 'Error de autenticación.');
      return;
    }

    try {
      // Llama a la API con el término de búsqueda y la página 1.
      final response = await UsersAPI.get(token, page: 1, query: _searchQuery);
      if (mounted) {
        setState(() {
          _users = response.data;
          // Si la API devuelve menos de 15 resultados, asumimos que es la última página.
          _hasNextPage = response.data.length == 15;
        });
      }
    } catch (error) {
      if (mounted) setState(() => _errorMessage = 'Error al cargar usuarios: $error');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Carga las páginas siguientes cuando el usuario hace scroll.
  Future<void> _loadMoreUsers() async {
    if (mounted) setState(() => _isLoadMoreRunning = true);

    final token = Provider.of<CommonDataProvider>(context, listen: false).token;
    if (token == null) return;

    try {
      final nextPage = _currentPage + 1;
      // Pide la siguiente página a la API, manteniendo el término de búsqueda.
      final response = await UsersAPI.get(token, page: nextPage, query: _searchQuery);

      if (response.data.isNotEmpty && mounted) {
        setState(() {
          _users.addAll(response.data); // Añade los nuevos usuarios a la lista existente.
          _currentPage = nextPage;
          if (response.data.length < 15) _hasNextPage = false;
        });
      } else if (mounted) {
        setState(() => _hasNextPage = false);
      }
    } finally {
      if (mounted) setState(() => _isLoadMoreRunning = false);
    }
  }

  // Ejecuta la búsqueda con un pequeño retraso para no sobrecargar la API.
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted && query != _searchQuery) {
        _searchQuery = query;
        _fetchUsers(isSearching: true); // Lanza una nueva búsqueda.
      }
    });
  }

  // Cambia el estado de un usuario (activo/inactivo).
  Future<void> _toggleUserStatus(User user) async {
    final originalStatus = user.isActive;
    setState(() {
      user.isActive = originalStatus == 1 ? 0 : 1;
    });

    try {
      final token = Provider.of<CommonDataProvider>(context, listen: false).token;
      await UsersAPI.update(user.id, user, token);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Estado de ${user.name} actualizado.'), backgroundColor: Colors.green),
      );
    } catch (error) {
      setState(() {
        user.isActive = originalStatus;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: $error'), backgroundColor: Colors.red),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Buscar por nombre o email...",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _searchController.clear();
                _onSearchChanged('');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddUserScreen()),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
      );
    }
    if (_users.isEmpty) {
      return Center(
        child: Text(_searchQuery.isEmpty
            ? 'No hay usuarios para mostrar.'
            : 'No se encontraron usuarios para "$_searchQuery".'),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _users.length + (_hasNextPage ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _users.length) {
          // Indicador de carga para la paginación
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final user = _users[index];
        final isExpanded = _expandedUserId == user.id;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: ExpansionTile(
            key: ValueKey('${user.id}-$isExpanded'), // Fuerza reconstrucción
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedUserId = expanded ? user.id : null;
              });
            },
            title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(user.email),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(_getInitials(user.name), style: const TextStyle(color: Colors.white)),
            ),
            trailing: Switch(
              value: user.isActive == 1,
              onChanged: (_) => _toggleUserStatus(user),
              activeColor: Colors.green,
            ),
            children: [
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.visibility),
                      label: const Text('Ver'),
                      onPressed: () {},
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar'),
                      onPressed: () {},
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.assignment_ind),
                      label: const Text('Asignar'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  String _getInitials(String name) {
    if (name.isEmpty) return '';
    List<String> names = name.split(' ');
    String initials = names[0][0];
    if (names.length > 1) {
      initials += names[names.length - 1][0];
    }
    return initials.toUpperCase();
  }
}