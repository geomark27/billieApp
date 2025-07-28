/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/role.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditRoleScreen extends StatefulWidget {
  const EditRoleScreen({super.key, required this.id});

  final int id;

  @override
  State<EditRoleScreen> createState() => _EditRoleScreenState();
}

class _EditRoleScreenState extends State<EditRoleScreen> {
  late final Role role;

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  void fetchData(BuildContext context, int index) {
    setState(() {
      role = context.read<CommonDataProvider>().roles[index];
      nameController.text = role.name;
      descriptionController.text = role.description ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();

    fetchData(context, widget.id);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Role",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
        ),
        AppInput(
          hintText: "Description",
          controller: descriptionController,
          multiline: true,
        ),
      ],
    );
  }
}
