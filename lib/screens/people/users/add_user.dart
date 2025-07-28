import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';
import 'package:salepro/screens/people/users/api/users.dart';
import 'package:salepro/models/message.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  String? role = "0";
  late TextEditingController emailController;
  late TextEditingController phoneController;
  bool isActive = true;
  bool isLoading = false;

  // Variables para manejo de errores de validación
  Map<String, List<String>> validationErrors = {};
  Message? message;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    // Agregar listeners para limpiar errores cuando el usuario escriba
    userNameController.addListener(() {
      if (userNameController.text.isNotEmpty &&
          validationErrors.containsKey('username')) {
        setState(() {
          validationErrors.remove('username');
        });
      }
    });

    emailController.addListener(() {
      if (emailController.text.isNotEmpty &&
          validationErrors.containsKey('email')) {
        setState(() {
          validationErrors.remove('email');
        });
      }
    });

    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty &&
          validationErrors.containsKey('password')) {
        setState(() {
          validationErrors.remove('password');
        });
      }
    });

    phoneController.addListener(() {
      if (phoneController.text.isNotEmpty &&
          validationErrors.containsKey('phone')) {
        setState(() {
          validationErrors.remove('phone');
        });
      }
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // Función para validar todos los campos
  bool validateForm() {
    validationErrors.clear();
    bool isValid = true;

    // Validar nombre de usuario
    if (userNameController.text.trim().isEmpty) {
      validationErrors['username'] = ['El nombre de usuario es requerido'];
      isValid = false;
    }

    // Validar email
    if (emailController.text.trim().isEmpty) {
      validationErrors['email'] = ['El email es requerido'];
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text.trim())) {
      validationErrors['email'] = ['Por favor ingrese un email válido'];
      isValid = false;
    }

    // Validar contraseña
    if (passwordController.text.trim().isEmpty) {
      validationErrors['password'] = ['La contraseña es requerida'];
      isValid = false;
    } else if (passwordController.text.length < 6) {
      validationErrors['password'] = [
        'La contraseña debe tener al menos 6 caracteres'
      ];
      isValid = false;
    }

    // Validar teléfono
    if (phoneController.text.trim().isEmpty) {
      validationErrors['phone'] = ['El número de teléfono es requerido'];
      isValid = false;
    }

    // Validar rol
    if (role == null || role == "0") {
      validationErrors['role'] = ['Debe seleccionar un rol'];
      isValid = false;
    }

    setState(() {}); // Actualizar la UI para mostrar errores
    return isValid;
  }

  // Función para manejar el envío del formulario
  void handleSubmit() async {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor complete todos los campos requeridos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
      message = null;
      validationErrors.clear();
    });

    try {
      // Obtener el token del provider
      final token = context.read<CommonDataProvider>().token;

      // Llamar a la API para crear el usuario
      final result = await UsersAPI.create(
        name: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        phone: phoneController.text.trim(),
        roleId: role!,
        isActive: isActive,
        token: token,
      );

      setState(() {
        message = result;
        isLoading = false;
      });

      if (result.success) {
        // Éxito - mostrar mensaje y navegar de vuelta
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.green,
          ),
        );

        // Limpiar formulario
        userNameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();
        setState(() {
          role = "0";
          isActive = true;
        });

        // Opcional: navegar hacia atrás
        // Navigator.of(context).pop();
      } else {
        // Error - mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );

        // Si hay errores específicos de campos, mostrarlos
        if (result.errors != null) {
          setState(() {
            validationErrors = Map<String, List<String>>.from(
              result.errors!.map((key, value) => MapEntry(
                    key,
                    value is List ? value.cast<String>() : [value.toString()],
                  )),
            );
          });
        }
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FormScreen(
          title: "Agregar usuario",
          onSubmit: handleSubmit,
          children: [
            AppInput(
              hintText: "Nombre de usuario *",
              controller: userNameController,
              errorLine:
                  validationErrors['username'] ?? validationErrors['name'],
            ),
            AppInput(
              hintText: "Email *",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              errorLine: validationErrors['email'],
            ),
            AppInput(
              hintText: "Contraseña *",
              password: true,
              controller: passwordController,
              errorLine: validationErrors['password'],
            ),
            AppInput(
              hintText: "Número de teléfono *",
              keyboardType: TextInputType.phone,
              controller: phoneController,
              errorLine:
                  validationErrors['phone'] ?? validationErrors['phone_number'],
            ),
            AppSelect(
              hintText: "Rol *",
              value: role,
              onChange: (String? value) {
                setState(() {
                  role = value;
                  // Limpiar error de rol cuando se selecciona uno
                  validationErrors.remove('role');
                  validationErrors.remove('role_id');
                });
              },
              items: [
                const {'label': "Seleccionar Rol *", 'value': "0"},
                ...context.watch<CommonDataProvider>().selectRolesData
              ],
              enableFilter: false,
              enableSearch: false,
              errorLine:
                  validationErrors['role'] ?? validationErrors['role_id'],
            ),
            AppCheckBox(
              hintText: "Activo",
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value!;
                });
              },
            ),
          ],
        ),
        // Overlay de carga
        if (isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
