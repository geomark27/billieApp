/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: card_payment
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/constants/spacing.dart';

class CardPaymentScreen extends StatelessWidget {
  const CardPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Card Payment',
          style: TextStyle(
            fontSize: AppSpacing.kDefaultPadding * 1.9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
