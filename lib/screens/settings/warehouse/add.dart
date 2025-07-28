/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/settings/warehouse/api/warehouse.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/warehouse/list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddWarehouseScreen extends StatefulWidget {
  const AddWarehouseScreen({super.key});

  @override
  State<AddWarehouseScreen> createState() => _AddWarehouseScreenState();
}

class _AddWarehouseScreenState extends State<AddWarehouseScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  Message? message;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);

    message = await WarehouseAPI.create(
      Warehouse(
        id: 0,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        numberOfProducts: 0,
        stockQuantity: 0,
      ),
      context.read<CommonDataProvider>().token,
    );
    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message!.success) {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "success");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const WarehouseListScreen(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Warehouse",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Name",
          placeholder: "Enter Warehouse Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppInput(
          hintText: "Phone",
          controller: phoneController,
          keyboardType: TextInputType.phone,
          errorLine: message?.errors?['phone'],
        ),
        AppInput(
          hintText: "Email",
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          errorLine: message?.errors?['email'],
        ),
        AppInput(
          hintText: "Address",
          controller: addressController,
          multiline: true,
          errorLine: message?.errors?['address'],
        ),
      ],
    );
  }
}
