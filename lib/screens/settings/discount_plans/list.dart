/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/discount_plans/add.dart';
import 'package:salepro/screens/settings/discount_plans/api/discount_plans.dart';
import 'package:salepro/screens/settings/discount_plans/edit.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class DiscountPlansScreen extends StatefulWidget {
  const DiscountPlansScreen({super.key});

  @override
  State<DiscountPlansScreen> createState() => _DiscountPlansScreenState();
}

class _DiscountPlansScreenState extends State<DiscountPlansScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getDiscountPlans();
  }

  Future<void> deletePlan(int id, BuildContext context) async {
    Loading.start(context);
    await DiscountPlansAPI.delete(id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const DiscountPlansScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Discount Plans",
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
      rows: context
          .watch<CommonDataProvider>()
          .discountPlans
          .map(
            (plan) => [
              plan.name,
              plan.customers.map((c) => c.customerName).toList().join(', '),
              plan.isActive == "1" ? "Active" : "Inactive"
            ],
          )
          .toList(),
      columns: const [
        "Name",
        "Customer",
        "Status",
      ],
      addPage: const AddDiscountPlanScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditDiscountPlanScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deletePlan(
                context.read<CommonDataProvider>().discountPlans[id].id,
                context,
              );
            },
            icon: Icons.delete,
            lightColor: AppColors.roseSwatch.shade600,
            darkColor: AppColors.roseSwatch.shade300,
          ),
        ];
      },
    );
  }
}
