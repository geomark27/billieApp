/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_sale
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/customers/add_customer.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditSaleScreen extends StatefulWidget {
  const EditSaleScreen({super.key});

  @override
  State<EditSaleScreen> createState() => _EditSaleScreenState();
}

class _EditSaleScreenState extends State<EditSaleScreen> {
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
  final List<Map<String, String>> orderDiscountTypes = [
    {
      "label": "Flat",
      "value": "flat",
    },
    {
      "label": "Percentage",
      "value": "percentage",
    },
  ];

  late TextEditingController dateController;
  late TextEditingController referenceController;
  String? customer;
  String? wareHouse = "0";
  String? biller = "0";
  String? currency = "usd";
  late TextEditingController exchangeRateController =
      TextEditingController(text: '1');

  String? product;
  String? orderTax = "0";
  String? orderDiscountType = "flat";
  late TextEditingController discountController;
  late TextEditingController shippingCostController;
  late TextEditingController documentController;
  String? saleStatus = "completed";
  String? paymentStatus = "pending";
  late TextEditingController saleNoteController;
  late TextEditingController staffNoteController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    referenceController = TextEditingController();
    discountController = TextEditingController();
    shippingCostController = TextEditingController();
    documentController = TextEditingController();
    saleNoteController = TextEditingController();
    staffNoteController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    referenceController.dispose();
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
      title: "Edit Sale",
      onSubmit: () {},
      children: [
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
        ),
        AppInput(
          hintText: "Reference No",
          controller: referenceController,
          keyboardType: TextInputType.number,
        ),
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
          screenToOpenOnSuffixTap: const AddCustomerScreen(),
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
        AppSelect(
          hintText: "Currency",
          value: currency,
          items: currencies,
          onChange: (value) {
            exchangeRateController.text = exchangeRates[value!]!;
            setState(() {
              currency = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Exchange Rate",
          controller: exchangeRateController,
          keyboardType: TextInputType.number,
        ),
        AppSelect(
          hintText: "Product",
          value: product,
          items: const [],
          onChange: (value) {
            setState(() {
              product = value;
            });
          },
          prefix: const Icon(
            FontAwesomeIcons.barcode,
          ),
          enableFilter: false,
          enableSearch: false,
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
        AppSelect(
          hintText: "Order Discount Type",
          value: orderDiscountType,
          items: orderDiscountTypes,
          onChange: (value) {
            setState(() {
              orderDiscountType = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Value",
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
        AppSelect(
          hintText: "Payment Status",
          value: paymentStatus,
          items: const [
            {"label": "Pending", "value": "pending"},
            {"label": "Due", "value": "due"},
            {"label": "Partial", "value": "partial"},
            {"label": "Paid", "value": "paid"},
          ],
          onChange: (value) {
            setState(() {
              paymentStatus = value;
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
