/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: categories
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/products/categories/api/product_categories.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/products/categories/add_category.dart';
import 'package:salepro/screens/products/categories/edit_category.dart';
import 'package:salepro/screens/products/categories/import_categories.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getProductCategories();
  }

  Future<void> deleteCategory(int id, BuildContext context) async {
    Loading.start(context);
    await ProductCategoriesAPI.delete(
        id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const CategoriesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Categories",
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
          .productCategories
          .map(
            (category) => [
              {"type": "image", "value": category.image},
              category.name,
              category.parent?.name,
              category.numberOfProducts,
              category.stockQuantity,
              category.stockWorth,
            ],
          )
          .toList(),
      columns: const [
        "Image",
        "Category",
        "Parent Category",
        "Number of Product",
        "Stock Quantity",
        "Stock Worth (Price/Cost)",
      ],
      importPage: const ImportCategoriesScreen(),
      addPage: const AddCategoryScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditCategoryScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteCategory(
                context.read<CommonDataProvider>().productCategories[id].id,
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
