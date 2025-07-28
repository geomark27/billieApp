/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_delivery
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddDeliveryScreen extends StatefulWidget {
  const AddDeliveryScreen({super.key});

  @override
  State<AddDeliveryScreen> createState() => _AddDeliveryScreenState();
}

class _AddDeliveryScreenState extends State<AddDeliveryScreen> {
  String? status = "packing";
  String? courier;
  late TextEditingController deliveredByController;
  late TextEditingController receivedByController;
  late TextEditingController fileController;
  late TextEditingController addressController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    deliveredByController = TextEditingController();
    receivedByController = TextEditingController();
    fileController = TextEditingController();
    addressController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    deliveredByController.dispose();
    receivedByController.dispose();
    fileController.dispose();
    addressController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Delivery",
      onSubmit: () {},
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.kDefaultPadding,
            right: AppSpacing.kDefaultPadding,
            bottom: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Delivery Reference:",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding * 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "dr-437948689-85906",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding,
                  fontWeight: FontWeight.w700,
                  color: useThemeMode(
                    context,
                    light:
                        getThemeColor(context)?.shade900.withValues(alpha: 0.6),
                    dark:
                        getThemeColor(context)?.shade100.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.kDefaultPadding,
            right: AppSpacing.kDefaultPadding,
            bottom: AppSpacing.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sale Reference:",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding * 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "dr-437948689-85906",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding,
                  fontWeight: FontWeight.w700,
                  color: useThemeMode(
                    context,
                    light:
                        getThemeColor(context)?.shade900.withValues(alpha: 0.6),
                    dark:
                        getThemeColor(context)?.shade100.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSelect(
          hintText: "Courier",
          items: const [
            {"label": "Fedex", "value": "fedex"},
          ],
          value: courier,
          onChange: (value) {
            setState(() {
              courier = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Delivered By",
          controller: deliveredByController,
        ),
        AppInput(
          hintText: "Received By",
          controller: receivedByController,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.kDefaultPadding,
            right: AppSpacing.kDefaultPadding,
            bottom: AppSpacing.kDefaultPadding,
            top: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Customer",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding * 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Walk in Customer",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding,
                  fontWeight: FontWeight.w700,
                  color: useThemeMode(
                    context,
                    light:
                        getThemeColor(context)?.shade900.withValues(alpha: 0.6),
                    dark:
                        getThemeColor(context)?.shade100.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppFilePicker(
          hintText: "Attach File",
          allowMultiple: false,
          controller: fileController,
        ),
        AppInput(
          controller: addressController,
          hintText: "Address",
          multiline: true,
        ),
        AppInput(
          controller: noteController,
          hintText: "Note",
          multiline: true,
        ),
      ],
    );
  }
}
