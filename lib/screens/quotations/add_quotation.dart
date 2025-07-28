/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_quotation
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddQuotationScreen extends StatefulWidget {
  const AddQuotationScreen({super.key});

  @override
  State<AddQuotationScreen> createState() => _AddQuotationScreenState();
}

class _AddQuotationScreenState extends State<AddQuotationScreen> {
  final List<Map<String, String>> statuses = [
    {
      "label": "Pending",
      "value": "pending",
    },
    {
      "label": "Sent",
      "value": "sent",
    },
  ];

  String? biller = "0";
  String? supplier;
  String? customer;
  String? warehouse = "0";
  String? product;
  String? orderTax = "0";
  late TextEditingController orderDiscountController;
  late TextEditingController shippingCostController;
  String? status = "pending";
  late TextEditingController documentController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    orderDiscountController = TextEditingController();
    shippingCostController = TextEditingController();
    documentController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    orderDiscountController.dispose();
    shippingCostController.dispose();
    documentController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Quotation",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Biller",
          items: [
            const {'label': "Select Biller*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectBillersData
          ],
          onChange: (value) {
            setState(() {
              biller = value;
            });
          },
          value: biller,
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Supplier",
          items: context.watch<CommonDataProvider>().selectSuppliersData,
          onChange: (value) {
            setState(() {
              supplier = value;
            });
          },
          value: supplier,
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Customer",
          items: context.watch<CommonDataProvider>().selectCustomersData,
          onChange: (value) {
            setState(() {
              customer = value;
            });
          },
          value: customer,
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Warehouse",
          items: [
            const {'label': "Select Warehouse*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          onChange: (value) {
            setState(() {
              warehouse = value;
            });
          },
          value: warehouse,
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Product(s)",
          items: const [],
          onChange: (value) {
            setState(() {
              product = value;
            });
          },
          prefix: const Icon(
            FontAwesomeIcons.barcode,
          ),
          value: product,
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Order Tax",
          items: context.watch<CommonDataProvider>().selectProductTaxesData,
          onChange: (value) {
            setState(() {
              orderTax = value;
            });
          },
          value: orderTax,
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Order Discount",
          controller: orderDiscountController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Shipping Cost",
          controller: shippingCostController,
          keyboardType: TextInputType.number,
        ),
        AppSelect(
          hintText: "Status",
          items: statuses,
          onChange: (value) {
            setState(() {
              status = value;
            });
          },
          value: status,
          enableFilter: false,
          enableSearch: false,
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
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
        ),
      ],
    );
  }
}
