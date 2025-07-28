/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_category
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/products/categories/api/product_categories.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/products/categories/models/product_category.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/products/categories/categories.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key, required this.id});

  final int id;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  Message? message;
  late ProductCategory productCategory;
  late TextEditingController nameController;
  String? category;
  bool disableWoocommerce = false;

  void fetchData(BuildContext context, int index) {
    setState(() {
      productCategory =
          context.read<CommonDataProvider>().productCategories[index];
      nameController.text = productCategory.name;
      category = productCategory.parentId.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();

    fetchData(context, widget.id);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);

    message = await ProductCategoriesAPI.update(
      productCategory.id,
      ProductCategory(
        id: 0,
        name: nameController.text,
        parentId: category == "null"
            ? null
            : int.tryParse(
                category.toString(),
              ),
        numberOfProducts: 0,
        stockQuantity: 0,
        stockWorth: "",
        disableWoocommerce: disableWoocommerce,
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
          builder: (ctx) => const CategoriesScreen(),
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
      title: 'Edit Category',
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Category Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppSelect(
          hintText: "Parent Category",
          value: category.toString(),
          items: [
            const {"label": "No Parent Category", "value": "null"},
            ...context
                .watch<CommonDataProvider>()
                .selectProductCategoriesData
                .where(
              (c) {
                return c['value'] != productCategory.id.toString();
              },
            ),
          ],
          onChange: (value) {
            setState(() {
              category = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['parent_id'],
        ),
        AppCheckBox(
          hintText: "Disable Woocommerce Sync",
          value: disableWoocommerce,
          onChanged: (bool? value) {
            setState(() {
              disableWoocommerce = value!;
            });
          },
          errorLine: message?.errors?['disable_woocommerce'],
        ),
      ],
    );
  }
}
