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
import 'package:salepro/models/message.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/taxes/add.dart';
import 'package:salepro/screens/settings/taxes/api/taxes.dart';
import 'package:salepro/screens/settings/taxes/edit.dart';
import 'package:salepro/screens/settings/taxes/import.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class TaxesListScreen extends StatefulWidget {
  const TaxesListScreen({super.key});

  @override
  State<TaxesListScreen> createState() => _TaxesListScreenState();
}

class _TaxesListScreenState extends State<TaxesListScreen> {
  bool requirePagination = false;
  Message? message;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getTaxes();
  }

  Future<void> deleteTax(int id, BuildContext context) async {
    Loading.start(context);
    message = await TaxAPI.delete(
      id,
      context.read<CommonDataProvider>().token,
    );
    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const TaxesListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Taxes List",
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
          .taxes
          .map(
            (tax) => [
              tax.name,
              tax.rate,
            ],
          )
          .toList(),
      columns: const [
        "Name",
        "Rate(%)",
      ],
      addPage: AddTaxScreen(),
      importPage: ImportTaxesScreen(),
      importTooltip: "Import Tax",
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditTaxScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteTax(
                context.read<CommonDataProvider>().taxes[id].id,
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
