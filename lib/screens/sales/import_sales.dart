/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import_sales
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/import_data.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class ImportSalesScreen extends StatefulWidget {
  const ImportSalesScreen({super.key});

  @override
  State<ImportSalesScreen> createState() => _ImportSalesScreenState();
}

class _ImportSalesScreenState extends State<ImportSalesScreen> {
  final List<Map<String, String>> currencies = [
    {
      "label": "USD",
      "value": "usd",
    },
    {
      "label": "EURO",
      "value": "euro",
    },
  ];
  final Map<String, String> exchangeRates = {
    "usd": "1",
    "euro": "0.95",
  };

  String? customer;
  String? wareHouse = "0";
  String? biller = "0";

  late TextEditingController fileController;
  String? orderTax = "0";
  String? orderDiscountType = "flat";
  late TextEditingController discountController;
  late TextEditingController shippingCostController;
  late TextEditingController documentController;
  String? saleStatus = "completed";
  late TextEditingController saleNoteController;
  late TextEditingController staffNoteController;

  @override
  void initState() {
    super.initState();
    fileController = TextEditingController();
    discountController = TextEditingController();
    shippingCostController = TextEditingController();
    documentController = TextEditingController();
    saleNoteController = TextEditingController();
    staffNoteController = TextEditingController();
  }

  @override
  void dispose() {
    fileController.dispose();
    discountController.dispose();
    shippingCostController.dispose();
    documentController.dispose();
    saleNoteController.dispose();
    staffNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Import Sale",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Customer",
          value: customer,
          items: const [],
          onChange: (value) {
            setState(() {
              customer = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Warehouse",
          value: wareHouse,
          items: [
            const {'label': "Select Warehouse*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          onChange: (value) {
            setState(() {
              wareHouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Biller",
          value: biller,
          items: [
            const {'label': "Select Biller*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectBillersData
          ],
          onChange: (value) {
            setState(() {
              biller = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding,
          ),
          child: ImportData(
            controller: fileController,
            prefix: const [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSpacing.kDefaultPadding * 0.5,
                ),
                child: Text(
                  "The correct column order is (product_code, quantity, sale_unit_code, price, discount_per_unit, tax_name) and you must follow this. For Digital product sale_unit will be n/a. All columns are required",
                  style: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSelect(
          hintText: "Order Tax",
          value: orderTax,
          items: context.watch<CommonDataProvider>().selectProductTaxesData,
          onChange: (value) {
            setState(() {
              orderTax = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Order Discount",
          controller: discountController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Shipping Cost",
          controller: shippingCostController,
          keyboardType: TextInputType.number,
        ),
        AppFilePicker(
          hintText: "Document",
          allowMultiple: false,
          allowedExtensions: const [
            'jpg',
            'jpeg',
            'png',
            'gif',
            'pdf',
            'csv',
            'docx',
            'xlsx',
            'txt'
          ],
          controller: documentController,
          info:
              "Only jpg, jpeg, png, gif, pdf, csv, docx, xlsx and txt file is supported.",
        ),
        AppSelect(
          hintText: "Sale Status",
          value: saleStatus,
          items: const [
            {"label": "Completed", "value": "completed"},
            {"label": "Pending", "value": "pending"},
          ],
          onChange: (value) {
            setState(() {
              saleStatus = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Sale Note",
          controller: saleNoteController,
          multiline: true,
        ),
        AppInput(
          hintText: "Staff Note",
          controller: staffNoteController,
          multiline: true,
        ),
      ],
    );
  }
}
