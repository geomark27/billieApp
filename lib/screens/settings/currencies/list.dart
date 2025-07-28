/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/currencies/add.dart';
import 'package:salepro/screens/settings/currencies/api/currencies.dart';
import 'package:salepro/screens/settings/currencies/edit.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class CurrenciesListScreen extends StatefulWidget {
  const CurrenciesListScreen({super.key});

  @override
  State<CurrenciesListScreen> createState() => _CurrenciesListScreenState();
}

class _CurrenciesListScreenState extends State<CurrenciesListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getCurrencies();
  }

  Future<void> deleteCurrency(int id, BuildContext context) async {
    Loading.start(context);
    await CurrencyAPI.delete(id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const CurrenciesListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Currencies List",
      requirePagination: requirePagination,
      fetchMethod: () async {
        Data data = await fetchData(context);
        setState(() {
          requirePagination = data.requirePagination;
        });
      },
      onRefresh: () async {
        Data data = await fetchData(context);
        setState(() {
          requirePagination = data.requirePagination;
        });
      },
      rows: context
          .watch<CommonDataProvider>()
          .currencies
          .map(
            (currency) => [
              currency.name,
              currency.code,
              currency.exchangeRate.toStringAsFixed(2),
            ],
          )
          .toList(),
      columns: [
        "Currency Name",
        "Currency Code",
        "Exchange Rate",
      ],
      addPage: AddCurrencyScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditCurrencyScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteCurrency(
                context.read<CommonDataProvider>().brands[id].id,
                context,
              );
            },
            icon: Icons.delete,
            lightColor: AppColors.roseSwatch.shade600,
            darkColor: AppColors.roseSwatch.shade300,
          ),
        ];
      },
    );
  }
}
