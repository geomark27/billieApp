/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: cheque_payment
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/constants/spacing.dart';

class ChequePaymentScreen extends StatelessWidget {
  const ChequePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cheque Payment'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Cheque Payment',
          style: TextStyle(
            fontSize: AppSpacing.kDefaultPadding * 1.9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
