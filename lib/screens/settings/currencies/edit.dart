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
import 'package:salepro/screens/settings/currencies/api/currencies.dart';
import 'package:salepro/screens/settings/currencies/list.dart';
import 'package:salepro/screens/settings/currencies/models/currency.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditCurrencyScreen extends StatefulWidget {
  const EditCurrencyScreen({super.key, required this.id});

  final int id;

  @override
  State<EditCurrencyScreen> createState() => _EditCurrencyScreenState();
}

class _EditCurrencyScreenState extends State<EditCurrencyScreen> {
  late Currency currency;
  Message? message;
  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController exchangeRateController;

  void fetchData(BuildContext context, int index) {
    setState(() {
      currency = context.read<CommonDataProvider>().currencies[index];
      nameController.text = currency.name;
      codeController.text = currency.code;
      exchangeRateController.text = currency.exchangeRate.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    codeController = TextEditingController();
    exchangeRateController = TextEditingController();
    fetchData(context, widget.id);
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    exchangeRateController.dispose();

    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await CurrencyAPI.update(
      currency.id,
      Currency(
        id: currency.id,
        name: nameController.text,
        code: codeController.text,
        exchangeRate: double.tryParse(exchangeRateController.text) ?? 1,
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
          builder: (ctx) => const CurrenciesListScreen(),
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
      title: "Edit Currency",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppInput(
          hintText: "Code",
          controller: codeController,
          errorLine: message?.errors?['code'],
        ),
        AppInput(
          hintText: "Exchange Rate",
          controller: exchangeRateController,
          keyboardType: TextInputType.number,
          info:
              "If this is your default currency, the exchange rate must be 1.",
          errorLine: message?.errors?['exchange_rate'],
        ),
      ],
    );
  }
}
