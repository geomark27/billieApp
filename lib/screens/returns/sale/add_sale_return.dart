/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_sale_return
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddSaleReturnScreen extends StatefulWidget {
  const AddSaleReturnScreen({super.key});

  @override
  State<AddSaleReturnScreen> createState() => _AddSaleReturnScreenState();
}

class _AddSaleReturnScreenState extends State<AddSaleReturnScreen> {
  late TextEditingController referenceController;

  @override
  void initState() {
    super.initState();
    referenceController = TextEditingController();
  }

  @override
  void dispose() {
    referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'Add Sale Return',
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Sale Reference",
          controller: referenceController,
        ),
      ],
    );
  }
}
