/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/settings/units/api/unit.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/units/models/unit.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/units/list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({super.key});

  @override
  State<AddUnitScreen> createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  late TextEditingController codeController;
  late TextEditingController nameController;
  String? baseUnit = "null";
  late TextEditingController operatorController;
  late TextEditingController operationValueController;
  Message? message;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    operatorController = TextEditingController(text: "*");
    operationValueController = TextEditingController(text: "1");
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    operatorController.dispose();
    operationValueController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await UnitAPI.create(
      Unit(
        id: 0,
        code: codeController.text,
        name: nameController.text,
        baseUnitId: baseUnit == "null" ? null : int.parse(baseUnit!),
        operator: operatorController.text,
        operationValue: int.tryParse(operationValueController.text) ?? 1,
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
          builder: (ctx) => const UnitsListScreen(),
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
      title: "Add Unit",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Code",
          controller: codeController,
          errorLine: message?.errors?['unit_code'],
        ),
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['unit_name'],
        ),
        AppSelect(
          hintText: "Base Unit",
          items: [
            const {'value': "null", "label": "No Base Unit"},
            ...context.watch<CommonDataProvider>().selectUnitsData
          ],
          value: '$baseUnit',
          onChange: (value) {
            setState(() {
              baseUnit = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['base_unit'],
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(),
          secondChild: Column(
            children: generateInputGroups([
              AppInput(
                hintText: "Operator",
                controller: operatorController,
                errorLine: message?.errors?['operator'],
              ),
              AppInput(
                hintText: "Operation Value",
                controller: operationValueController,
                errorLine: message?.errors?['operation_value'],
              ),
            ]),
          ),
          crossFadeState: baseUnit == 'null'
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(
            milliseconds: 700,
          ),
        )
      ],
    );
  }
}
