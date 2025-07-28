/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/settings/brands/api/brands.dart';
import 'package:salepro/screens/settings/brands/models/brand.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/brands/list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddBrandScreen extends StatefulWidget {
  const AddBrandScreen({super.key});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  Message? message;
  late TextEditingController nameController;
  late TextEditingController imageController;
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
      message = await BrandAPI.create(
        Brand(
          id: 0,
          title: nameController.text,
        ),
        context.read<CommonDataProvider>().token,
        fileData: {
          'key': 'image',
          'path': path.toString(),
        },
      );
    } else {
      message = await BrandAPI.create(
        Brand(
          id: 0,
          title: nameController.text,
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
          builder: (ctx) => const BrandsListScreen(),
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
      title: 'Add Brand',
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Brand Name",
          controller: nameController,
          errorLine: message?.errors?['title'],
        ),
        AppFilePicker(
          allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif'],
          hintText: "Image",
          allowMultiple: false,
          controller: imageController,
          onChanged: (img) {
            setState(() {
              path = (img as File).path;
            });
          },
          errorLine: message?.errors?['image'],
        ),
      ],
    );
  }
}
