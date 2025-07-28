/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: view_sale
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/screens/sales/models/sale.dart';
import 'package:salepro/widgets/app_table.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/summary_box.dart';

class ViewSaleScreen extends StatelessWidget {
  const ViewSaleScreen({super.key, required this.sale});

  final Sale sale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sale.referenceNo,
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: generateInputGroups(
            [
              SizedBox(),
              SummaryBox(
                title: "Sale Details",
                children: [
                  SizedBox(),
                  SummaryItem(
                    title: "Date",
                    value: sale.date,
                  ),
                  SummaryItem(
                    title: "Reference",
                    value: sale.referenceNo,
                  ),
                  SummaryItem(
                    title: "Warehouse",
                    value: sale.warehouse?.name ?? "No Warehouse Selected",
                  ),
                  SummaryItem(
                    title: "Sale Status",
                    value: sale.saleStatus,
                  ),
                  SummaryItem(
                    title: "Currency",
                    value: sale.currency?.name ?? "USD",
                  ),
                  SummaryItem(
                    title: "Exchange Rate",
                    value: sale.currency?.exchangeRate.toString() ?? "1.0",
                  ),
                ],
              ),
              if (sale.biller != null)
                SummaryBox(
                  title: "From",
                  children: [
                    SizedBox(),
                    SummaryItem(
                      title: "Name",
                      value: sale.biller!.name.toString(),
                    ),
                    SummaryItem(
                      title: "Company Name",
                      value: sale.biller!.companyName.toString(),
                    ),
                    SummaryItem(
                      title: "Email",
                      value: sale.biller!.email.toString(),
                    ),
                    SummaryItem(
                      title: "Phone",
                      value: sale.biller!.phoneNumber.toString(),
                    ),
                    SummaryItem(
                      title: "Address",
                      value: sale.biller!.address.toString(),
                    ),
                    SummaryItem(
                      title: "City",
                      value: sale.biller!.city.toString(),
                    ),
                  ],
                ),
              if (sale.customer != null)
                SummaryBox(
                  title: "To",
                  children: [
                    SizedBox(),
                    SummaryItem(
                      title: "Name",
                      value: sale.customer!.customerName.toString(),
                    ),
                    SummaryItem(
                      title: "Phone",
                      value: sale.customer!.phoneNumber.toString(),
                    ),
                    SummaryItem(
                      title: "Address",
                      value: sale.customer!.address.toString(),
                    ),
                    SummaryItem(
                      title: "City",
                      value: sale.customer!.city.toString(),
                    ),
                  ],
                ),
              if (sale.products != null)
                AppTable(
                  rows: [
                    ...sale.products!.map(
                      (p) => [
                        p.id,
                        "${p.name} [${p.code}]",
                        "N/A",
                        "${p.saleQty ?? 0} ${p.unit?.name ?? "pc"}",
                        sale.returnAmount,
                        p.saleNetUnitPrice?.toStringAsFixed(2) ?? p.price,
                        "${p.saleTax?.toStringAsFixed(2) ?? "0"} (${p.saleTaxRate?.toStringAsFixed(2) ?? "0"}%)",
                        p.saleDiscount?.toStringAsFixed(2) ?? "0",
                        p.saleTotal?.toStringAsFixed(2) ?? "0",
                        sale.deliveryStatus,
                      ],
                    ),
                    [
                      "Total:",
                      {"type": "blank"},
                      {"type": "blank"},
                      sale.products!
                          .fold(
                            0,
                            (value, product) => product.saleQty != null
                                ? value + product.saleQty!
                                : value,
                          )
                          .toString(),
                      {"type": "blank"},
                      {"type": "blank"},
                      sale.products!
                          .fold(
                            0.00,
                            (value, product) => product.saleTax != null
                                ? value + product.saleTax!
                                : value,
                          )
                          .toStringAsFixed(2),
                      sale.products!
                          .fold(
                            0.00,
                            (value, product) => product.saleDiscount != null
                                ? value + product.saleDiscount!
                                : value,
                          )
                          .toStringAsFixed(2),
                      sale.products!
                          .fold(
                            0.00,
                            (value, product) => product.saleTax != null &&
                                    product.saleDiscount != null &&
                                    product.saleTotal != null
                                ? value +
                                    product.saleTotal! +
                                    product.saleTax! -
                                    product.saleDiscount!
                                : value,
                          )
                          .toStringAsFixed(2),
                      {"type": "blank"},
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
                    "Delivered",
                  ],
                ),
              SummaryBox(
                children: [
                  SummaryItem(
                    title: "Order Tax",
                    value: sale.orderTax == null
                        ? "0 (0%)"
                        : "${sale.orderTax!.rate / 100 * int.parse(sale.subTotal ?? "0")} (${sale.orderTax!.rate}%)",
                  ),
                  SummaryItem(
                    title: "Order Discount",
                    value:
                        sale.orderDiscount == null ? "0" : sale.orderDiscount!,
                  ),
                  SummaryItem(
                    title: "Shipping Cost",
                    value: sale.shippingCost == null ? "0" : sale.shippingCost!,
                  ),
                  SummaryItem(
                    title: "Grand Total",
                    value: sale.grandTotal,
                  ),
                  SummaryItem(
                    title: "Paid",
                    value: sale.paidAmount,
                  ),
                  SummaryItem(
                    title: "Due",
                    value: sale.dueAmount,
                  ),
                ],
              ),
              if (sale.saleNote != null)
                SummaryBox(
                  title: "Sale Note",
                  children: [
                    SummaryItem(title: "Note", value: sale.saleNote!),
                  ],
                ),
              if (sale.staffNote != null)
                SummaryBox(
                  title: "Staff Note",
                  children: [
                    SummaryItem(title: "Note", value: sale.staffNote!),
                  ],
                ),
              if (sale.createdBy != null)
                SummaryBox(
                  title: "Created By",
                  children: [
                    SummaryItem(title: "Name", value: sale.createdBy!.name),
                    SummaryItem(title: "Email", value: sale.createdBy!.email),
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
