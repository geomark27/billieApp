/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_purchase
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/purchases/api/purchases.dart';
import 'package:salepro/screens/purchases/models/purchase.dart';
import 'package:salepro/screens/purchases/purchase_list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/product_table.dart';
import 'package:salepro/widgets/select.dart';
import 'package:salepro/widgets/sortable_table.dart';
import 'package:salepro/widgets/summary_box.dart';

class AddPurchaseScreen extends StatefulWidget {
  const AddPurchaseScreen({super.key});

  @override
  State<AddPurchaseScreen> createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  late TextEditingController dateController;
  late TextEditingController referenceController;
  String? wareHouse = "0";
  String? supplier;
  String? purchaseStatus = "received";
  late TextEditingController documentController;

  String? currency = "usd";
  late TextEditingController exchangeRateController;

  List<Product> products = [];
  String? orderTax = "0";
  late TextEditingController discountController;
  double discount = 0;
  late TextEditingController shippingCostController;
  double shippingCost = 0;
  late TextEditingController noteController;
  double total = 0;
  int totalQuantity = 0;
  Message? message;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    referenceController = TextEditingController();
    documentController = TextEditingController();
    discountController = TextEditingController(text: "0");
    shippingCostController = TextEditingController(text: "0");
    noteController = TextEditingController();
    exchangeRateController = TextEditingController(text: '1.0');
  }

  @override
  void dispose() {
    dateController.dispose();
    referenceController.dispose();
    documentController.dispose();
    discountController.dispose();
    shippingCostController.dispose();
    noteController.dispose();
    exchangeRateController.dispose();
    super.dispose();
  }

  void onSelectProduct(String? value) {
    final index = products.indexWhere(
      (p) => p.code.toString() == value.toString(),
    );
    if (index == -1) {
      setState(() {
        final product = Product.fromJson(
          {
            ...context
                .read<CommonDataProvider>()
                .products[
                    context.read<CommonDataProvider>().products.indexWhere(
                          (p) => p.code.toString() == value.toString(),
                        )]
                .toMap(),
            'quantity': 1
          },
        );
        total += double.parse(product.costSubtotal ?? "0.0");
        products = [
          ...products,
          product,
        ];
        totalQuantity += 1;
      });
    } else {
      setState(() {
        final product = Product.fromJson(
          {
            ...products[index].toMap(),
            'quantity': products[index].quantity + 1
          },
        );
        total = total -
            double.parse(products[index].costSubtotal ?? "0.0") +
            double.parse(product.costSubtotal ?? "0.0");
        products[index] = product;
        totalQuantity += 1;
      });
    }
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await PurchaseAPI.create(
      Purchase(
        id: 0,
        date: dateController.text,
        referenceNo: referenceController.text,
        purchaseStatus: purchaseStatus ?? "1",
        subTotal: total.toStringAsFixed(2),
        grandTotal: (total +
                total * double.parse(orderTax ?? "0.0") / 100 -
                discount +
                shippingCost)
            .toStringAsFixed(2),
        exchangeRate: exchangeRateController.text.isEmpty
            ? 1.00
            : double.parse(exchangeRateController.text),
        supplier: context.read<CommonDataProvider>().suppliers[
            context.read<CommonDataProvider>().suppliers.indexWhere(
                  (t) => t.id.toString() == supplier,
                )],
        warehouse: context.read<CommonDataProvider>().wareHouses[
            context.read<CommonDataProvider>().wareHouses.indexWhere(
                  (t) => t.id.toString() == wareHouse,
                )],
        currency: context.read<CommonDataProvider>().currencies[
            context.read<CommonDataProvider>().currencies.indexWhere(
                  (t) => t.id.toString() == currency,
                )],
        products: products,
        orderTax: orderTax != null && orderTax.toString() != "0"
            ? context.read<CommonDataProvider>().taxes[
                context.read<CommonDataProvider>().taxes.indexWhere(
                      (t) => t.rate.toString() == orderTax,
                    )]
            : null,
        orderDiscount: discount.toStringAsFixed(2),
        shippingCost: shippingCost.toStringAsFixed(2),
        note: noteController.text,
        returnAmount: '0.00',
        paidAmount: '0.00',
        dueAmount: '0.00',
        paymentStatus: '0',
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
          builder: (ctx) => const PurchaseListScreen(),
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
      title: "Add Purchase",
      onSubmit: handleSubmit,
      children: [
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
          errorLine: message?.errors?['created_at'],
        ),
        AppInput(
          hintText: "Reference No",
          controller: referenceController,
          keyboardType: TextInputType.number,
          errorLine: message?.errors?['reference_no'],
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
          errorLine: message?.errors?['warehouse_id'],
        ),
        AppSelect(
          hintText: "Supplier",
          value: supplier,
          items: context.watch<CommonDataProvider>().selectSuppliersData,
          onChange: (value) {
            setState(() {
              supplier = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['supplier_id'],
        ),
        AppSelect(
          hintText: "Purchase Status",
          value: purchaseStatus,
          items: context.watch<CommonDataProvider>().selectPurchaseStatusData,
          onChange: (value) {
            setState(() {
              purchaseStatus = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['status'],
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
          hintText: "Currency",
          value: currency,
          items: context.watch<CommonDataProvider>().selectCurrenciesData,
          onChange: (value) {
            setState(() {
              exchangeRateController.text = context
                  .read<CommonDataProvider>()
                  .currencies[context
                      .read<CommonDataProvider>()
                      .currencies
                      .indexWhere((c) => c.id.toString() == value)]
                  .exchangeRate
                  .toString();
              currency = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['currency_id'],
        ),
        AppInput(
          hintText: "Exchange Rate",
          controller: exchangeRateController,
          keyboardType: TextInputType.number,
          errorLine: message?.errors?['exchange_rate'],
        ),
        ProductTable(
          value: "",
          rows: products
              .map(
                (p) => [
                  p.name,
                  p.code,
                  p.quantity,
                  p.cost,
                  "0.00",
                  p.costTax,
                  p.costSubtotal
                ],
              )
              .toList(),
          columns: [
            "Name",
            "Code",
            "Quantity",
            "Net Unit Cost",
            "Discount",
            "Tax",
            "Subtotal",
          ],
          onChange: onSelectProduct,
          tableActions: (id) {
            return [
              TableActionIcon(
                iconType: NavLink.materialIcon,
                onTap: () {
                  setState(() {
                    products.removeAt(id);
                  });
                },
                icon: Icons.delete,
                lightColor: AppColors.roseSwatch.shade600,
                darkColor: AppColors.roseSwatch.shade300,
              ),
            ];
          },
        ),
        AppSelect(
          hintText: "Order Tax",
          value: orderTax,
          items: [
            {"label": "No Tax", "value": "0"},
            ...context.watch<CommonDataProvider>().selectProductTaxesData
          ],
          onChange: (value) {
            setState(() {
              orderTax = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['order_tax'],
        ),
        AppInput(
          hintText: "Discount",
          controller: discountController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              discount = value.isEmpty ? 0 : double.parse(value);
            });
          },
          errorLine: message?.errors?['discount'],
        ),
        AppInput(
          hintText: "Shipping Cost",
          controller: shippingCostController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              shippingCost = value.isEmpty ? 0 : double.parse(value);
            });
          },
          errorLine: message?.errors?['shipping_cost'],
        ),
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
          errorLine: message?.errors?['note'],
        ),
        SizedBox(
          height: AppSpacing.kDefaultPadding,
        ),
        SummaryBox(
          children: [
            SummaryItem(
              title: "Items",
              value: "${products.length} ($totalQuantity)",
            ),
            SummaryItem(
              title: "Total",
              value: total.toStringAsFixed(2),
            ),
            SummaryItem(
              title: "Order Tax",
              value: (total * double.parse(orderTax ?? "0.0") / 100)
                  .toStringAsFixed(2),
            ),
            SummaryItem(
              title: "Order Discount",
              value: discount.toStringAsFixed(2),
            ),
            SummaryItem(
              title: "Shipping Cost",
              value: shippingCost.toStringAsFixed(2),
            ),
            SummaryItem(
              title: "Grand Total",
              value: (total +
                      total * double.parse(orderTax ?? "0.0") / 100 -
                      discount +
                      shippingCost)
                  .toStringAsFixed(2),
            ),
          ],
        ),
      ],
    );
  }
}
