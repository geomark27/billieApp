/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: view_purchase
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/screens/purchases/models/purchase.dart';
import 'package:salepro/widgets/app_table.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/summary_box.dart';

class ViewPurchaseScreen extends StatelessWidget {
  const ViewPurchaseScreen({super.key, required this.purchase});

  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          purchase.referenceNo,
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: generateInputGroups(
            [
              SizedBox(),
              SummaryBox(
                title: "Purchase Details",
                children: [
                  SizedBox(),
                  SummaryItem(
                    title: "Date",
                    value: purchase.date,
                  ),
                  SummaryItem(
                    title: "Reference",
                    value: purchase.referenceNo,
                  ),
                  SummaryItem(
                    title: "Purchase Status",
                    value: purchase.purchaseStatus,
                  ),
                  SummaryItem(
                    title: "Currency",
                    value: purchase.currency?.name ?? "USD",
                  ),
                  SummaryItem(
                    title: "Exchange Rate",
                    value: purchase.currency?.exchangeRate.toString() ?? "1.0",
                  ),
                ],
              ),
              if (purchase.supplier != null)
                SummaryBox(
                  title: "From",
                  children: [
                    SizedBox(),
                    SummaryItem(
                      title: "Name",
                      value: purchase.supplier!.name.toString(),
                    ),
                    SummaryItem(
                      title: "Company Name",
                      value: purchase.supplier!.companyName.toString(),
                    ),
                    SummaryItem(
                      title: "Email",
                      value: purchase.supplier!.email.toString(),
                    ),
                    SummaryItem(
                      title: "Phone",
                      value: purchase.supplier!.phoneNumber.toString(),
                    ),
                    SummaryItem(
                      title: "Address",
                      value: purchase.supplier!.address.toString(),
                    ),
                    SummaryItem(
                      title: "City",
                      value: purchase.supplier!.city.toString(),
                    ),
                  ],
                ),
              if (purchase.warehouse != null)
                SummaryBox(
                  title: "To",
                  children: [
                    SizedBox(),
                    SummaryItem(
                      title: "Warehouse",
                      value: purchase.warehouse!.name.toString(),
                    ),
                    SummaryItem(
                      title: "Phone",
                      value: purchase.warehouse!.phone.toString(),
                    ),
                    SummaryItem(
                      title: "Address",
                      value: purchase.warehouse!.address.toString(),
                    ),
                  ],
                ),
              if (purchase.products != null)
                AppTable(
                  rows: [
                    ...purchase.products!.map(
                      (p) => [
                        p.id,
                        "${p.name} [${p.code}]",
                        "N/A",
                        "${p.quantity} ${p.unit?.name ?? "pc"}",
                        purchase.returnAmount,
                        p.price,
                        "${p.costTax ?? "0"} (${p.taxRate?.rate ?? "0"}%)",
                        "0",
                        p.costSubtotal,
                      ],
                    ),
                    [
                      "Total:",
                      {"type": "blank"},
                      {"type": "blank"},
                      purchase.products!
                          .fold(
                            0,
                            (value, product) => value + product.quantity,
                          )
                          .toString(),
                      {"type": "blank"},
                      {"type": "blank"},
                      purchase.products!
                          .fold(
                            0.00,
                            (value, product) => product.taxRate != null
                                ? value +
                                    double.parse(product.price) *
                                        product.taxRate!.rate /
                                        100
                                : value,
                          )
                          .toStringAsFixed(2),
                      purchase.products!
                          .fold(
                            0.00,
                            (value, product) =>
                                value +
                                double.parse(
                                    product.discount.replaceAll(",", "")),
                          )
                          .toStringAsFixed(2),
                      purchase.products!
                          .fold(
                            0.00,
                            (value, product) =>
                                value +
                                double.parse(product.costSubtotal
                                    .toString()
                                    .replaceAll(",", "")),
                          )
                          .toStringAsFixed(2),
                    ],
                  ],
                  columns: [
                    "#",
                    "Product",
                    "Batch No",
                    "Qty",
                    "Returned",
                    "Unit Price",
                    "Tax",
                    "Discount",
                    "Subtotal",
                  ],
                ),
              SummaryBox(
                children: [
                  SummaryItem(
                    title: "Order Tax",
                    value: purchase.orderTax == null
                        ? "0 (0%)"
                        : "${purchase.orderTax!.rate / 100 * int.parse(purchase.subTotal ?? "0")} (${purchase.orderTax!.rate}%)",
                  ),
                  SummaryItem(
                    title: "Order Discount",
                    value: purchase.orderDiscount == null
                        ? "0"
                        : purchase.orderDiscount!,
                  ),
                  SummaryItem(
                    title: "Shipping Cost",
                    value: purchase.shippingCost == null
                        ? "0"
                        : purchase.shippingCost!,
                  ),
                  SummaryItem(
                    title: "Grand Total",
                    value: purchase.grandTotal,
                  ),
                  SummaryItem(
                    title: "Paid",
                    value: purchase.paidAmount,
                  ),
                  SummaryItem(
                    title: "Due",
                    value: purchase.dueAmount,
                  ),
                ],
              ),
              if (purchase.note != null)
                SummaryBox(
                  title: "Purchase Note",
                  children: [
                    SummaryItem(title: "Note", value: purchase.note!),
                  ],
                ),
              SizedBox(
                height: AppSpacing.kDefaultPadding * 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
