/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_category
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/products/categories/api/product_categories.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/products/categories/categories.dart';
import 'package:salepro/screens/products/categories/models/product_category.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  Message? message;
  late TextEditingController nameController;
  late TextEditingController imageController;
  String? category = "null";
  bool disableWoocommerce = false;
  String? path;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    imageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    if (path != null) {
      message = await ProductCategoriesAPI.create(
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
        fileData: {
          'key': 'image',
          'path': path.toString(),
        },
      );
    } else {
      message = await ProductCategoriesAPI.create(
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
    }
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
      title: 'Add Category',
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Category Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppFilePicker(
          allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif'],
          hintText: "Image",
          allowMultiple: false,
          controller: imageController,
          errorLine: message?.errors?['image'],
          onChanged: (img) {
            setState(() {
              path = (img as File).path;
            });
          },
        ),
        AppSelect(
          hintText: "Parent Category",
          items: [
            const {"label": "No Parent Category", "value": "null"},
            ...context.watch<CommonDataProvider>().selectProductCategoriesData,
          ],
          onChange: (value) {
            setState(() {
              category = value;
            });
          },
          value: category,
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
