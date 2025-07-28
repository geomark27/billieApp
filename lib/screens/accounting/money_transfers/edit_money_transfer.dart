/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_money_transfer
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/accounting/api/money_transfers.dart';
import 'package:salepro/screens/accounting/models/money_transfer.dart';
import 'package:salepro/screens/accounting/money_transfers/money_transfer_list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditMoneyTransferScreen extends StatefulWidget {
  const EditMoneyTransferScreen({super.key, required this.id});

  final int id;

  @override
  State<EditMoneyTransferScreen> createState() =>
      _EditMoneyTransferScreenState();
}

class _EditMoneyTransferScreenState extends State<EditMoneyTransferScreen> {
  String? from;
  String? to;
  late TextEditingController amountController;
  late MoneyTransfer moneyTransfer;
  Message? message;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    setState(() {
      moneyTransfer =
          context.read<CommonDataProvider>().moneyTransfers[widget.id];
      from = moneyTransfer.fromAccount?.id.toString();
      to = moneyTransfer.toAccount?.id.toString();
      amountController.text = moneyTransfer.amount.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await MoneyTransfersAPI.update(
      moneyTransfer.id,
      MoneyTransfer(
        id: moneyTransfer.id,
        amount: double.tryParse(amountController.text) ?? 0,
        referenceNo: '',
        date: '',
        fromAccount: context.read<CommonDataProvider>().accounts[
            context.read<CommonDataProvider>().accounts.indexWhere(
                  (a) => a.id.toString() == from,
                )],
        toAccount: context.read<CommonDataProvider>().accounts[
            context.read<CommonDataProvider>().accounts.indexWhere(
                  (a) => a.id.toString() == to,
                )],
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
          builder: (ctx) => const MoneyTransferListScreen(),
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
      title: "Edit Money Transfer",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "From Account",
          value: from,
          items: context.watch<CommonDataProvider>().selectAccountsData,
          onChange: (value) {
            setState(() {
              from = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['from_account_id'],
        ),
        AppSelect(
          hintText: "To Account",
          value: to,
          items: context.watch<CommonDataProvider>().selectAccountsData,
          onChange: (value) {
            setState(() {
              to = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['to_account_id'],
        ),
        AppInput(
          hintText: "Amount",
          controller: amountController,
          keyboardType: TextInputType.number,
          errorLine: message?.errors?['amount'],
        ),
      ],
    );
  }
}
