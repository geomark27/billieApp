/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddDiscountScreen extends StatefulWidget {
  const AddDiscountScreen({super.key});

  @override
  State<AddDiscountScreen> createState() => _AddDiscountScreenState();
}

class _AddDiscountScreenState extends State<AddDiscountScreen> {
  late TextEditingController nameController;
  String? discountPlan;
  bool? active = true;
  String? applicableFor = "all";
  String? product;
  late TextEditingController validFromController;
  late TextEditingController validTillController;
  String? discountType = "percentage";
  late TextEditingController valueController;
  late TextEditingController minQtyController;
  late TextEditingController maxQtyController;
  bool? validOnMonday = true;
  bool? validOnTuesday = true;
  bool? validOnWednesday = true;
  bool? validOnThursday = true;
  bool? validOnFriday = true;
  bool? validOnSaturday = true;
  bool? validOnSunday = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    validFromController = TextEditingController();
    validTillController = TextEditingController();
    valueController = TextEditingController();
    minQtyController = TextEditingController();
    maxQtyController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    validFromController.dispose();
    validTillController.dispose();
    valueController.dispose();
    minQtyController.dispose();
    maxQtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Create Discount",
      onSubmit: () {},
      children: [
        AppCheckBox(
          hintText: "Active",
          value: active!,
          onChanged: (value) {
            setState(() {
              active = value!;
            });
          },
        ),
        AppInput(
          hintText: "Name",
          controller: nameController,
        ),
        AppSelect(
          hintText: "Discount Plan",
          value: discountPlan,
          items: const [],
          onChange: (value) {
            setState(() {
              discountPlan = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Applicable for",
          value: applicableFor,
          items: const [
            {"label": "All Products", "value": "all"},
            {"label": "Specific Products", "value": "specific"},
          ],
          onChange: (value) {
            setState(() {
              applicableFor = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(
            width: 0,
            height: 0,
          ),
          secondChild: AppSelect(
            hintText: "Product",
            value: product,
            items: const [],
            onChange: (value) {
              setState(() {
                product = value;
              });
            },
            enableFilter: false,
            enableSearch: false,
          ),
          crossFadeState: applicableFor == "all"
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(
            seconds: 1,
          ),
        ),
        AppDatePicker(
          hintText: "Valid From",
          controller: validFromController,
        ),
        AppDatePicker(
          hintText: "Valid Till",
          controller: validTillController,
        ),
        AppSelect(
          hintText: "Discount Type",
          value: discountType,
          items: const [
            {"label": "Percentage (%)", "value": "percentage"},
            {"label": "Flat", "value": "flat"},
          ],
          onChange: (value) {
            setState(() {
              discountType = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Value",
          controller: valueController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Minimum Qty",
          controller: minQtyController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Maximum Qty",
          controller: maxQtyController,
          keyboardType: TextInputType.number,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding,
            horizontal: AppSpacing.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Valid on the following days",
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: AppSpacing.kDefaultPadding,
              ),
              AppCheckBox(
                hintText: "Monday",
                value: validOnMonday!,
                onChanged: (value) {
                  setState(() {
                    validOnMonday = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Tuesday",
                value: validOnTuesday!,
                onChanged: (value) {
                  setState(() {
                    validOnTuesday = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Wednesday",
                value: validOnWednesday!,
                onChanged: (value) {
                  setState(() {
                    validOnWednesday = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Thursday",
                value: validOnThursday!,
                onChanged: (value) {
                  setState(() {
                    validOnThursday = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Friday",
                value: validOnFriday!,
                onChanged: (value) {
                  setState(() {
                    validOnFriday = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Saturday",
                value: validOnSaturday!,
                onChanged: (value) {
                  setState(() {
                    validOnSaturday = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Sunday",
                value: validOnSunday!,
                onChanged: (value) {
                  setState(() {
                    validOnSunday = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
