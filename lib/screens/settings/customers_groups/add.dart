/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/customers_groups/api/customer_groups.dart';
import 'package:salepro/screens/settings/customers_groups/list.dart';
import 'package:salepro/screens/settings/customers_groups/models/customer_group.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddCustomerGroupScreen extends StatefulWidget {
  const AddCustomerGroupScreen({super.key});

  @override
  State<AddCustomerGroupScreen> createState() => _AddCustomerGroupScreenState();
}

class _AddCustomerGroupScreenState extends State<AddCustomerGroupScreen> {
  late TextEditingController nameController;
  late TextEditingController percentageController;
  Message? message;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    percentageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await CustomerGroupAPI.create(
      CustomerGroup(
        id: 0,
        name: nameController.text,
        percentage: percentageController.text,
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
          builder: (ctx) => const CustomerGroupsListScreen(),
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
      title: "Add Customer Group",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppInput(
          hintText: "Percentage(%)",
          controller: percentageController,
          keyboardType: TextInputType.number,
          info:
              "If you want to sell your product at default price then the percentage value must be zero.",
          errorLine: message?.errors?['percentage'],
        ),
      ],
    );
  }
}
