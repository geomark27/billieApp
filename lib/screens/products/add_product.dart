/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_product
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/expenses/categories/add_category.dart';
import 'package:salepro/screens/products/api/products.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/products/product_list.dart';
import 'package:salepro/screens/settings/brands/add.dart';
import 'package:salepro/screens/settings/taxes/add.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/editor.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/input.dart' as input;
import 'package:salepro/widgets/select.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late String type;
  late TextEditingController nameController;
  late TextEditingController codeController;
  late String barcodeSymbology;
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
  late String productTax;
  late String taxMethod;
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
  Message? message;

  @override
  void initState() {
    super.initState();
    type =
        context.read<CommonDataProvider>().selectProductTypesData[0]['value'];
    barcodeSymbology = context
        .read<CommonDataProvider>()
        .selectBarcodeSymbologiesData[0]['value'];
    productTax =
        context.read<CommonDataProvider>().selectProductTaxesData[0]['value'];
    taxMethod =
        context.read<CommonDataProvider>().selectTaxMethodsData[0]['value'];
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

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await ProductsAPI.create(
      Product(
        id: 0,
        stockWorth: "",
        quantity: 1,
        type: type,
        name: nameController.text,
        code: codeController.text,
        barcodeSymbology: barcodeSymbology,
        brand: context.read<CommonDataProvider>().brands[
            context.read<CommonDataProvider>().selectBrandsData.indexWhere(
                  (b) => b['value'] == brand,
                )],
        category: context.read<CommonDataProvider>().productCategories[context
            .read<CommonDataProvider>()
            .selectProductCategoriesData
            .indexWhere(
              (c) => c['value'] == category,
            )],
        unit: context.read<CommonDataProvider>().units[
            context.read<CommonDataProvider>().units.indexWhere(
                  (u) => u.id.toString() == unit,
                )],
        purchaseUnit: purchaseUnit == null
            ? null
            : context.read<CommonDataProvider>().units[
                context.read<CommonDataProvider>().units.indexWhere(
                      (u) => u.id.toString() == purchaseUnit,
                    )],
        saleUnit: saleUnit == null
            ? null
            : context.read<CommonDataProvider>().units[
                context.read<CommonDataProvider>().units.indexWhere(
                      (u) => u.id.toString() == saleUnit,
                    )],
        cost: costController.text,
        price: priceController.text,
        discount: "0",
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
          builder: (ctx) => const ProductListScreen(),
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
      title: "Add Product",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "Product Type",
          value: type,
          items: context.watch<CommonDataProvider>().selectProductTypesData,
          onChange: (value) {
            setState(() {
              type = value!;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['type'],
        ),
        AppInput(
          hintText: "Product Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppInput(
          hintText: "Product Code",
          controller: codeController,
          actionIcon: FontAwesomeIcons.rotate,
          actionIconProvider: input.InputIcon.fontAwesomeIcon,
          onAction: () async {
            final code = await ProductsAPI.generateCode(
              context.read<CommonDataProvider>().token,
            );
            setState(() {
              codeController.text = code;
            });
          },
          errorLine: message?.errors?['code'],
        ),
        AppSelect(
          hintText: "Barcode Symbology",
          value: barcodeSymbology,
          items:
              context.watch<CommonDataProvider>().selectBarcodeSymbologiesData,
          onChange: (value) {
            setState(() {
              barcodeSymbology = value!;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['barcode_symbology'],
        ),
        AppSelect(
          hintText: "Brand",
          value: brand,
          items: context.watch<CommonDataProvider>().selectBrandsData,
          onChange: (value) {
            setState(() {
              brand = value!;
            });
          },
          screenToOpenOnSuffixTap: const AddBrandScreen(),
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['brand_id'],
        ),
        AppSelect(
          hintText: "Category",
          value: category,
          items:
              context.watch<CommonDataProvider>().selectProductCategoriesData,
          onChange: (value) {
            setState(() {
              category = value!;
            });
          },
          screenToOpenOnSuffixTap: const AddExpenseCategoryScreen(),
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['category_id'],
        ),
        AppSelect(
          hintText: "Product Unit",
          value: unit,
          items: context.watch<CommonDataProvider>().selectBaseUnitsData,
          onChange: (value) {
            setState(() {
              unit = value!;
              saleUnit = context
                  .read<CommonDataProvider>()
                  .selectUnitsDataWithBase(unit)[0]['value'];
              purchaseUnit = context
                  .read<CommonDataProvider>()
                  .selectUnitsDataWithBase(unit)[0]['value'];
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['unit_id'],
        ),
        AppSelect(
          hintText: "Sale Unit",
          value: saleUnit,
          items: unit != null
              ? context
                  .watch<CommonDataProvider>()
                  .selectUnitsDataWithBase(unit)
              : [],
          onChange: (value) {
            setState(() {
              saleUnit = value!;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['sale_unit_id'],
        ),
        AppSelect(
          hintText: "Purchase Unit",
          value: purchaseUnit,
          items: unit != null
              ? context
                  .watch<CommonDataProvider>()
                  .selectUnitsDataWithBase(unit)
              : [],
          onChange: (value) {
            setState(() {
              purchaseUnit = value!;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['purchase_unit_id'],
        ),
        AppInput(
          hintText: "Product Cost",
          controller: costController,
          errorLine: message?.errors?['cost'],
        ),
        AppInput(
          hintText: "Product Price",
          controller: priceController,
          errorLine: message?.errors?['price'],
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
          screenToOpenOnSuffixTap: const AddTaxScreen(),
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Tax Method",
          value: taxMethod,
          items: context.watch<CommonDataProvider>().selectTaxMethodsData,
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
      ],
    );
  }
}
