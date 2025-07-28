/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/taxes/api/taxes.dart';
import 'package:salepro/screens/settings/taxes/list.dart';
import 'package:salepro/screens/settings/taxes/models/tax.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditTaxScreen extends StatefulWidget {
  const EditTaxScreen({super.key, required this.id});

  final int id;

  @override
  State<EditTaxScreen> createState() => _EditTaxScreenState();
}

class _EditTaxScreenState extends State<EditTaxScreen> {
  late TextEditingController nameController;
  late TextEditingController rateController;
  late Tax tax;
  Message? message;

  void fetchData(BuildContext context, int index) {
    setState(() {
      tax = context.read<CommonDataProvider>().taxes[index];
      nameController.text = tax.name;
      rateController.text = tax.rate.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    rateController = TextEditingController();
    fetchData(context, widget.id);
  }

  @override
  void dispose() {
    nameController.dispose();
    rateController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await TaxAPI.update(
      tax.id,
      Tax(
        id: tax.id,
        name: nameController.text,
        rate: int.tryParse(rateController.text) ?? 0,
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
          builder: (ctx) => const TaxesListScreen(),
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
      title: 'Edit Tax',
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Tax Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppInput(
          hintText: "Rate(%)",
          controller: rateController,
          keyboardType: TextInputType.number,
          errorLine: message?.errors?['rate'],
        ),
      ],
    );
  }
}
