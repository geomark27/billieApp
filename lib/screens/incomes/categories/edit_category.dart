/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_category
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/incomes/categories/api/income_categories.dart';
import 'package:salepro/screens/incomes/categories/categories.dart';
import 'package:salepro/screens/incomes/categories/models/income_category.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditIncomeCategoryScreen extends StatefulWidget {
  const EditIncomeCategoryScreen({super.key, required this.id});

  final int id;

  @override
  State<EditIncomeCategoryScreen> createState() =>
      _EditIncomeCategoryScreenState();
}

class _EditIncomeCategoryScreenState extends State<EditIncomeCategoryScreen> {
  late TextEditingController codeController;
  late TextEditingController nameController;
  Message? message;
  late IncomeCategory incomeCategory;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    setState(() {
      incomeCategory =
          context.read<CommonDataProvider>().incomeCategories[widget.id];
      codeController.text = incomeCategory.code;
      nameController.text = incomeCategory.name;
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await IncomeCategoriesAPI.update(
      incomeCategory.id,
      IncomeCategory(
        id: incomeCategory.id,
        name: nameController.text,
        code: codeController.text,
        isActive: true,
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
          builder: (ctx) => const IncomeCategoriesScreen(),
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
      title: "Edit Income Category",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Code",
          controller: codeController,
          actionIcon: FontAwesomeIcons.rotate,
          actionIconProvider: InputIcon.fontAwesomeIcon,
          onAction: () {},
          errorLine: message?.errors?['code'],
        ),
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
      ],
    );
  }
}
