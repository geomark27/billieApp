/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sales_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/sales/add_sale.dart';
import 'package:salepro/screens/sales/edit_sale.dart';
import 'package:salepro/screens/sales/import_sales.dart';
import 'package:salepro/screens/sales/view_sale.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getSales();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Sales List",
      requirePagination: requirePagination,
      fetchMethod: () async {
        Data data = await fetchData(context);
        setState(() {
          requirePagination = data.requirePagination;
        });
      },
      onRefresh: () async {
        Data data = await fetchData(context);
        setState(() {
          requirePagination = data.requirePagination;
        });
      },
      loadNewPage: (count) async {
        await context.read<CommonDataProvider>().getSalesPaginated(count);
      },
      rows: context
          .watch<CommonDataProvider>()
          .sales
          .map(
            (purchase) => [
              purchase.date,
              purchase.referenceNo,
              purchase.biller?.name ?? "No Biller Provided",
              purchase.customer?.name ?? "No Customer Provided",
              purchase.saleStatus,
              purchase.paymentStatus,
              purchase.paymentMethod,
              purchase.deliveryStatus,
              purchase.grandTotal,
              purchase.returnAmount,
              purchase.paidAmount,
              purchase.dueAmount,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference",
        "Biller",
        "Customer",
        "Sale Status",
        "Payment Status",
        "Payment Method",
        "Delivery Status",
        "Grand Total",
        "Returned Amount",
        "Paid",
        "Due",
      ],
      addPage: AddSaleScreen(),
      importPage: ImportSalesScreen(),
      importTooltip: "Import Sales",
      onTap: (int id) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ViewSaleScreen(
              sale: context.read<CommonDataProvider>().sales[id],
            ),
          ),
        );
      },
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditSaleScreen(),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {},
            icon: Icons.delete,
            lightColor: AppColors.roseSwatch.shade600,
            darkColor: AppColors.roseSwatch.shade300,
          ),
        ];
      },
    );
  }
}
