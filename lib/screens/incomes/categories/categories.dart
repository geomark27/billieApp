/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: categories
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/incomes/categories/add_category.dart';
import 'package:salepro/screens/incomes/categories/api/income_categories.dart';
import 'package:salepro/screens/incomes/categories/edit_category.dart';
import 'package:salepro/screens/incomes/categories/import_categories.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class IncomeCategoriesScreen extends StatefulWidget {
  const IncomeCategoriesScreen({super.key});

  @override
  State<IncomeCategoriesScreen> createState() => _IncomeCategoriesScreenState();
}

class _IncomeCategoriesScreenState extends State<IncomeCategoriesScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getIncomeCategories();
  }

  Future<void> deleteIncome(int id, BuildContext context) async {
    Loading.start(context);
    await IncomeCategoriesAPI.delete(
        id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const IncomeCategoriesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Income Categories",
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
          .incomeCategories
          .map(
            (ic) => [
              ic.code,
              ic.name,
            ],
          )
          .toList(),
      columns: ["Code", "Name"],
      addPage: AddIncomeCategoryScreen(),
      importPage: ImportIncomeCategoriesScreen(),
      importTooltip: "Import Income Categories",
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditIncomeCategoryScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteIncome(
                context.read<CommonDataProvider>().incomeCategories[id].id,
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
