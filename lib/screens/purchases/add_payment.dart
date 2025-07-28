/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_payment
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/constants/spacing.dart';

class AddPaymentScreen extends StatelessWidget {
  const AddPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Add Payment',
          style: TextStyle(
            fontSize: AppSpacing.kDefaultPadding * 1.9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
