/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/products/add_product.dart';
import 'package:salepro/screens/products/api/products.dart';
import 'package:salepro/screens/products/edit_product.dart';
import 'package:salepro/screens/products/import_products.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool requirePagination = false;
  Message? message;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getProducts();
  }

  Future<void> deleteProduct(int id, BuildContext context) async {
    Loading.start(context);
    message = await ProductsAPI.delete(
      id,
      context.read<CommonDataProvider>().token,
    );
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
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const ProductListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Product List",
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
        await context.read<CommonDataProvider>().getProductsPaginated(count);
      },
      dataRowHeight: AppSpacing.kDefaultPadding * 4,
      rows: context
          .watch<CommonDataProvider>()
          .products
          .map(
            (product) => [
              {"type": "image", "value": product.image},
              product.name,
              product.code,
              product.brand?.title ?? "No Brand",
              product.category?.name ?? "No Category",
              product.quantity,
              product.unit?.name ?? "No Unit Provided",
              product.price,
              product.cost,
              product.stockWorth,
            ],
          )
          .toList(),
      columns: [
        "Image",
        "Name",
        "Code",
        "Brand",
        "Category",
        "Quantity",
        "Unit",
        "Price",
        "Cost",
        "Stock Worth (Price/Cost)",
      ],
      addPage: AddProductScreen(),
      importPage: ImportProductScreen(),
      importTooltip: "Import Products",
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditProductScreen(),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteProduct(
                context.read<CommonDataProvider>().products[id].id,
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
