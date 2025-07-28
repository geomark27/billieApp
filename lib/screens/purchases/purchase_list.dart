/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/purchases/add_purchase.dart';
import 'package:salepro/screens/purchases/edit_purchase.dart';
import 'package:salepro/screens/purchases/import_purchases.dart';
import 'package:salepro/screens/purchases/view_purchase.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class PurchaseListScreen extends StatefulWidget {
  const PurchaseListScreen({super.key});

  @override
  State<PurchaseListScreen> createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends State<PurchaseListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getPurchases();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Purchase List",
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
        await context.read<CommonDataProvider>().getPurchasesPaginated(count);
      },
      rows: context
          .watch<CommonDataProvider>()
          .purchases
          .map(
            (purchase) => [
              purchase.date,
              purchase.referenceNo,
              purchase.supplier?.name ?? "No Supplier Provided",
              purchase.purchaseStatus,
              purchase.grandTotal,
              purchase.returnAmount,
              purchase.paidAmount,
              purchase.dueAmount,
              purchase.paymentStatus,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference",
        "Supplier",
        "Purchase Status",
        "Grand Total",
        "Returned Amount",
        "Paid",
        "Due",
        "Payment Status",
      ],
      addPage: AddPurchaseScreen(),
      importPage: ImportPurchasesScreen(),
      importTooltip: "Import Purchase",
      onTap: (int id) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ViewPurchaseScreen(
              purchase: context.read<CommonDataProvider>().purchases[id],
            ),
          ),
        );
      },
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditPurchaseScreen(),
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
