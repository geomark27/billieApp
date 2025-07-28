/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_count_stock
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class AddCountStockScreen extends StatefulWidget {
  const AddCountStockScreen({super.key});

  @override
  State<AddCountStockScreen> createState() => _AddCountStockScreenState();
}

class _AddCountStockScreenState extends State<AddCountStockScreen> {
  String? warehouse = "0";
  String? type;

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Count Stock",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Warehouse",
          value: warehouse,
          items: [
            const {'label': "Select Warehouse*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          onChange: (value) {
            setState(() {
              warehouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Type",
          value: type,
          items: const [
            {
              "label": "Full",
              "value": "full",
            },
            {
              "label": "Partial",
              "value": "partial",
            },
          ],
          onChange: (value) {
            setState(() {
              type = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
      ],
    );
  }
}
