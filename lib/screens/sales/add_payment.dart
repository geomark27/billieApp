/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_payment
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  late TextEditingController receivedAmountController;
  late TextEditingController payingAmountController;
  String? paidBy = "cash";
  late TextEditingController paymentReceiverController;
  String? account;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    receivedAmountController = TextEditingController(text: "2000");
    payingAmountController = TextEditingController(text: "1000");
    paymentReceiverController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    receivedAmountController.dispose();
    payingAmountController.dispose();
    paymentReceiverController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final change = double.parse(receivedAmountController.text) -
        double.parse(payingAmountController.text);

    return FormScreen(
      title: "Add Payment",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Received Amount",
          controller: receivedAmountController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Paying Amount",
          controller: payingAmountController,
          keyboardType: TextInputType.number,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding,
            vertical: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Text(
            "Change: ${change.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: AppSpacing.kDefaultPadding * 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AppSelect(
          hintText: "Paid By",
          items: const [
            {"label": "Cash", "value": "cash"},
            {"label": "Gift Card", "value": "giftcard"},
            {"label": "Credit Card", "value": "creditcard"},
            {"label": "Cheque", "value": "cheque"},
            {"label": "Deposit", "value": "deposit"},
            {"label": "Points", "value": "points"},
          ],
          onChange: (value) {
            setState(() {
              paidBy = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Payment Receiver",
          controller: paymentReceiverController,
        ),
        AppSelect(
          hintText: "Account",
          value: account,
          items: context.watch<CommonDataProvider>().selectAccountsData,
          onChange: (value) {
            setState(() {
              account = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Payment Note",
          controller: noteController,
          multiline: true,
        ),
      ],
    );
  }
}
