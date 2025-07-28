/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
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

class EditUnitScreen extends StatefulWidget {
  const EditUnitScreen({super.key, required this.id});

  final int id;

  @override
  State<EditUnitScreen> createState() => _EditUnitScreenState();
}

class _EditUnitScreenState extends State<EditUnitScreen> {
  late Unit unit;
  late TextEditingController codeController;
  late TextEditingController nameController;
  String? baseUnit = "null";
  late TextEditingController operatorController;
  late TextEditingController operationValueController;
  Message? message;

  void fetchData(BuildContext context, int index) {
    setState(() {
      unit = context.read<CommonDataProvider>().units[index];
      nameController.text = unit.name;
      codeController.text = unit.code;
      baseUnit = '${unit.baseUnit}';
      operatorController.text = unit.operator;
      operationValueController.text = '${unit.operationValue}';
    });
  }

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    operatorController = TextEditingController();
    operationValueController = TextEditingController();

    fetchData(context, widget.id);
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

    message = await UnitAPI.update(
      unit.id,
      Unit(
        id: unit.id,
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
      title: "Edit ${unit.name}",
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
            ...context.watch<CommonDataProvider>().selectUnitsData.where(
              (c) {
                return c['value'] != unit.id.toString();
              },
            ),
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
