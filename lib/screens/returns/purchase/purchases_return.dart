/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchases_return
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/returns/purchase/add_purchase_return.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class PurchasesReturnScreen extends StatefulWidget {
  const PurchasesReturnScreen({super.key});

  @override
  State<PurchasesReturnScreen> createState() => _PurchasesReturnScreenState();
}

class _PurchasesReturnScreenState extends State<PurchasesReturnScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getPurchaseReturns();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Purchases Return",
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
          .purchaseReturns
          .map(
            (r) => [
              r.date,
              r.referenceNo,
              r.saleReference,
              r.warehouse?.name ?? "No Warehouse Provided",
              r.supplier?.name ?? "No Supplier Provided",
              r.customer?.name ?? "No Customer Provided",
              r.grandTotal,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference",
        "Purchase Reference",
        "Warehouse",
        "Biller",
        "Customer",
        "Grand Total",
      ],
      addPage: AddPurchaseReturnScreen(),
      tableActions: (int id) {
        return [
          // TableActionIcon(
          //   iconType: NavLink.materialIcon,
          //   screen: EditSaleScreen(),
          //   icon: Icons.edit,
          // ),
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
