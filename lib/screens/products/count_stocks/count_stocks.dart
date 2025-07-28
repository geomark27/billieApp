/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: count_stocks
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/products/count_stocks/add_count_stock.dart';
import 'package:salepro/widgets/list.dart';

class CountStocksScreen extends StatelessWidget {
  const CountStocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Count Stocks",
      rows: [],
      columns: [],
      addPage: AddCountStockScreen(),
    );
  }
}
