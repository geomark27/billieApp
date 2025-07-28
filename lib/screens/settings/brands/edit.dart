/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/settings/brands/api/brands.dart';
import 'package:salepro/screens/settings/brands/models/brand.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/brands/list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditBrandScreen extends StatefulWidget {
  const EditBrandScreen({super.key, required this.id});

  final int id;

  @override
  State<EditBrandScreen> createState() => _EditBrandScreenState();
}

class _EditBrandScreenState extends State<EditBrandScreen> {
  late Brand brand;
  Message? message;
  late TextEditingController nameController;

  void fetchData(BuildContext context, int index) {
    setState(() {
      brand = context.read<CommonDataProvider>().brands[index];
      nameController.text = brand.title;
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
    message = await BrandAPI.update(
      brand.id,
      Brand(
        id: brand.id,
        title: nameController.text,
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
      title: 'Edit Brand',
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Brand Name",
          controller: nameController,
          errorLine: message?.errors?['title'],
        ),
      ],
    );
  }
}
