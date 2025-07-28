/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_product
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/editor.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/input.dart' as input;
import 'package:salepro/widgets/select.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final List<Map<String, String>> types = [
    {"label": "Standard", "value": "standard"},
    {"label": "Combo", "value": "combo"},
    {"label": "Digital", "value": "digital"},
    {"label": "Service", "value": "service"},
  ];

  final List<Map<String, String>> barcodeSymbologies = [
    {"label": "Code 128", "value": "code-128"},
    {"label": "Code 39", "value": "code-39"},
    {"label": "UPC-A", "value": "upc-a"},
    {"label": "UPC-E", "value": "upc-e"},
    {"label": "EAN-8", "value": "ean-8"},
    {"label": "EAN-13", "value": "ean-13"},
  ];

  final List<Map<String, String>> brands = [
    {"label": "Apple", "value": "apple"},
    {"label": "Samsung", "value": "samsung"},
    {"label": "Huawei", "value": "huawei"},
    {"label": "Xiaomi", "value": "xiaomi"},
    {"label": "Whirlpool", "value": "whirlpool"},
  ];

  final List<Map<String, String>> categories = [
    {
      "label": "Smartphone & Gadgets",
      "value": "smartphone",
    },
    {
      "label": "Phone Accessories",
      "value": "phone_accessories",
    },
    {
      "label": "iPhone",
      "value": "iphone",
    },
    {
      "label": "Samsung",
      "value": "samsung",
    },
    {
      "label": "Monitors",
      "value": "monitors",
    },
  ];
  final List<Map<String, String>> units = [
    {
      "label": "Piece",
      "value": "Piece",
    },
    {
      "label": "Kilogram",
      "value": "kilogram",
    },
  ];
  final List<Map<String, String>> taxes = [
    {
      "label": "No Tax",
      "value": "0",
    },
    {
      "label": "@10",
      "value": "1",
    },
    {
      "label": "@15",
      "value": "2",
    },
    {
      "label": "vat 20%",
      "value": "3",
    },
  ];
  final List<Map<String, String>> taxMethods = [
    {
      "label": "Inclusive",
      "value": "inclusive",
    },
    {
      "label": "Exclusive",
      "value": "exclusive",
    },
  ];

  String type = "standard";
  late TextEditingController nameController;
  late TextEditingController codeController;
  String barcodeSymbology = "code-128";
  String? brand;
  String? category;
  String? unit;
  String? saleUnit;
  String? purchaseUnit;
  late TextEditingController costController;
  late TextEditingController priceController;
  late TextEditingController wholesalePriceController;
  late TextEditingController dailySaleObjectiveController;
  late TextEditingController alertQuantityController;
  String productTax = "0";
  String taxMethod = "exclusive";
  bool initialStock = false;
  bool featured = false;
  bool embeddedBarcode = false;
  late TextEditingController imagesController;
  late QuillEditorController contentController;
  bool hasVariant = false;
  bool hasDifferentPriceBasedOnWarehouse = false;
  bool hasBatchAndExpiryDate = false;
  bool hasIMEIOrSerialNumbers = false;
  bool addPromotionalPrice = false;
  bool disableWoocommerceSync = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    codeController = TextEditingController();
    costController = TextEditingController();
    priceController = TextEditingController();
    wholesalePriceController = TextEditingController();
    dailySaleObjectiveController = TextEditingController();
    alertQuantityController = TextEditingController();
    imagesController = TextEditingController();
    contentController = QuillEditorController();
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    costController.dispose();
    priceController.dispose();
    wholesalePriceController.dispose();
    dailySaleObjectiveController.dispose();
    alertQuantityController.dispose();
    imagesController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(title: "Add Product", onSubmit: () {}, children: [
      AppSelect(
        hintText: "Product Type",
        value: type,
        items: types,
        onChange: (value) {
          setState(() {
            type = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppInput(
        hintText: "Product Name",
        controller: nameController,
      ),
      AppInput(
        hintText: "Product Code",
        controller: codeController,
        actionIcon: FontAwesomeIcons.rotate,
        actionIconProvider: input.InputIcon.fontAwesomeIcon,
        onAction: () {},
      ),
      AppSelect(
        hintText: "Barcode Symbology",
        value: barcodeSymbology,
        items: barcodeSymbologies,
        onChange: (value) {
          setState(() {
            barcodeSymbology = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppSelect(
        hintText: "Brand",
        value: brand,
        items: brands,
        onChange: (value) {
          setState(() {
            brand = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppSelect(
        hintText: "Category",
        value: category,
        items: categories,
        onChange: (value) {
          setState(() {
            category = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppSelect(
        hintText: "Product Unit",
        value: unit,
        items: units,
        onChange: (value) {
          setState(() {
            unit = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppSelect(
        hintText: "Sale Unit",
        value: saleUnit,
        items: const [],
        onChange: (value) {
          setState(() {
            saleUnit = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppSelect(
        hintText: "Purchase Unit",
        value: purchaseUnit,
        items: const [],
        onChange: (value) {
          setState(() {
            purchaseUnit = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppInput(
        hintText: "Product Cost",
        controller: costController,
      ),
      AppInput(
        hintText: "Product Price",
        controller: priceController,
      ),
      AppInput(
        hintText: "Wholesale Price",
        controller: wholesalePriceController,
      ),
      AppInput(
        hintText: "Daily Sale Objective",
        controller: dailySaleObjectiveController,
        info:
            "Minimum qty which must be sold in a day. If not, you will be notified on dashboard. But you have to set up the cron job properly for that. Follow the documentation in that regard.",
      ),
      AppInput(
        hintText: "Alert Quantity",
        controller: alertQuantityController,
      ),
      AppSelect(
        hintText: "Product Tax",
        value: productTax,
        items: context.watch<CommonDataProvider>().selectProductTaxesData,
        onChange: (value) {
          setState(() {
            productTax = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppSelect(
        hintText: "Tax Method",
        value: taxMethod,
        items: taxMethods,
        onChange: (value) {
          setState(() {
            taxMethod = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AppCheckBox(
        hintText: "Initial Stock",
        value: initialStock,
        onChanged: (value) {
          setState(() {
            initialStock = value!;
          });
        },
        info:
            "This feature will not work for product with variants and batches",
        showInfoIcon: false,
      ),
      AppCheckBox(
        hintText: "Featured",
        value: featured,
        onChanged: (value) {
          setState(() {
            featured = value!;
          });
        },
        info: "Featured product will be displayed in POS",
        showInfoIcon: false,
      ),
      AppCheckBox(
        hintText: "Embedded Barcode",
        value: embeddedBarcode,
        onChanged: (value) {
          setState(() {
            embeddedBarcode = value!;
          });
        },
        info:
            "Check this if this product will be used in weight scale machine.",
      ),
      AppFilePicker(
        allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif'],
        hintText: "Product Image(s)",
        controller: imagesController,
        allowMultiple: true,
        info:
            "You can upload multiple image. Only .jpeg, .jpg, .png, .gif file can be uploaded. First image will be base image.",
      ),
      Editor(
        controller: contentController,
        label: "Product Details",
      ),
      AppCheckBox(
        hintText: "This product has variant",
        value: hasVariant,
        onChanged: (value) {
          setState(() {
            hasVariant = value!;
          });
        },
      ),
      AppCheckBox(
        hintText: "This product has different price for different warehouse",
        value: hasDifferentPriceBasedOnWarehouse,
        onChanged: (value) {
          setState(() {
            hasDifferentPriceBasedOnWarehouse = value!;
          });
        },
      ),
      AppCheckBox(
        hintText: "This product has batch and expired date",
        value: hasBatchAndExpiryDate,
        onChanged: (value) {
          setState(() {
            hasBatchAndExpiryDate = value!;
          });
        },
      ),
      AppCheckBox(
        hintText: "This product has IMEI or Serial numbers",
        value: hasIMEIOrSerialNumbers,
        onChanged: (value) {
          setState(() {
            hasIMEIOrSerialNumbers = value!;
          });
        },
      ),
      AppCheckBox(
        hintText: "Add Promotional Price",
        value: addPromotionalPrice,
        onChanged: (value) {
          setState(() {
            addPromotionalPrice = value!;
          });
        },
      ),
      AppCheckBox(
        hintText: "Disable Woocommerce Sync",
        value: disableWoocommerceSync,
        onChanged: (value) {
          setState(() {
            disableWoocommerceSync = value!;
          });
        },
      ),
    ]);
  }
}
