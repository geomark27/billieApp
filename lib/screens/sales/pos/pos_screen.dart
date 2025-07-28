/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: pos_screen
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/constants/spacing.dart';

class POSScreen extends StatelessWidget {
  const POSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'POS',
          style: TextStyle(
            fontSize: AppSpacing.kDefaultPadding * 1.9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
