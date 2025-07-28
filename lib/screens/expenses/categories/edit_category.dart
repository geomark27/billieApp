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
import 'package:salepro/screens/expenses/categories/api/expense_categories.dart';
import 'package:salepro/screens/expenses/categories/categories.dart';
import 'package:salepro/screens/expenses/categories/models/expense_category.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditExpenseCategoryScreen extends StatefulWidget {
  const EditExpenseCategoryScreen({super.key, required this.id});

  final int id;

  @override
  State<EditExpenseCategoryScreen> createState() =>
      _EditExpenseCategoryScreenState();
}

class _EditExpenseCategoryScreenState extends State<EditExpenseCategoryScreen> {
  late TextEditingController codeController;
  late TextEditingController nameController;
  Message? message;
  late ExpenseCategory expenseCategory;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    setState(() {
      expenseCategory =
          context.read<CommonDataProvider>().expenseCategories[widget.id];
      codeController.text = expenseCategory.code;
      nameController.text = expenseCategory.name;
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
    message = await ExpenseCategoriesAPI.update(
      expenseCategory.id,
      ExpenseCategory(
        id: expenseCategory.id,
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
          builder: (ctx) => const ExpenseCategoriesScreen(),
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
      title: "Edit Expense Category",
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
