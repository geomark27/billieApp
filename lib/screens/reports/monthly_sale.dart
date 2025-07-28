/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: monthly_sale
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/constants/spacing.dart';

class MonthlySaleScreen extends StatelessWidget {
  const MonthlySaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Sale'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Monthly Sale',
          style: TextStyle(
            fontSize: AppSpacing.kDefaultPadding * 1.9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
