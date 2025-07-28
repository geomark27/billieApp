/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddCustomFieldScreen extends StatefulWidget {
  const AddCustomFieldScreen({super.key});

  @override
  State<AddCustomFieldScreen> createState() => _AddCustomFieldScreenState();
}

class _AddCustomFieldScreenState extends State<AddCustomFieldScreen> {
  String? belongsTo;
  late TextEditingController nameController;
  String? type;
  late TextEditingController defaultValueController;
  late TextEditingController gridController;
  bool? showOnTable = false;
  bool? showOnInvoice = false;
  bool? required = false;
  bool? adminOnly = false;
  bool? disabled = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    defaultValueController = TextEditingController();
    gridController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    defaultValueController.dispose();
    gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Custom Field",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Field Belongs To",
          value: belongsTo,
          items: const [
            {"label": "Product", "value": "product"},
            {"label": "Sale", "value": "sale"},
            {"label": "Purchase", "value": "purchase"},
            {"label": "Customer", "value": "customer"},
          ],
          onChange: (value) {
            setState(() {
              belongsTo = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Field Name",
          controller: nameController,
        ),
        AppSelect(
          hintText: "Field Type",
          value: belongsTo,
          items: const [
            {"label": "Text", "value": "text"},
            {"label": "Number", "value": "number"},
            {"label": "Textarea", "value": "textarea"},
            {"label": "Select", "value": "select"},
            {"label": "Multi Select", "value": "multiselect"},
            {"label": "Checkbox", "value": "checkbox"},
            {"label": "Radio Button", "value": "radio"},
            {"label": "Date Picker", "value": "datepicker"},
          ],
          onChange: (value) {
            setState(() {
              belongsTo = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Default Value",
          controller: defaultValueController,
        ),
        AppInput(
          hintText: "Grid (Bootstrap Column eq. 12) - Max is 12",
          controller: gridController,
          placeholder: "col-md-",
          keyboardType: TextInputType.number,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(
                  AppSpacing.kDefaultPadding,
                ),
                child: Text(
                  "Visibility",
                  style: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding * 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AppCheckBox(
                hintText: "Show on Table",
                value: showOnTable!,
                onChanged: (value) {
                  setState(() {
                    showOnTable = value!;
                  });
                },
              ),
              AppCheckBox(
                hintText: "Show on Invoice",
                value: showOnInvoice!,
                onChanged: (value) {
                  setState(() {
                    showOnInvoice = value!;
                  });
                },
              ),
            ],
          ),
        ),
        AppCheckBox(
          hintText: "Required",
          value: required!,
          onChanged: (value) {
            setState(() {
              required = value!;
            });
          },
        ),
        AppCheckBox(
          hintText: "Admin Only",
          value: adminOnly!,
          onChanged: (value) {
            setState(() {
              adminOnly = value!;
            });
          },
        ),
        AppCheckBox(
          hintText: "Disabled",
          value: disabled!,
          onChanged: (value) {
            setState(() {
              disabled = value!;
            });
          },
        ),
      ],
    );
  }
}
