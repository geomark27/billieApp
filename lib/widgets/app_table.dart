/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: app_table
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/widgets/app_table_scroller.dart';
import 'package:salepro/widgets/sortable_table.dart';

class AppTable extends StatelessWidget {
  const AppTable({
    super.key,
    required this.rows,
    required this.columns,
    this.tableActions,
    this.onTap,
    this.disabledIndexes,
  });

  final List<List<dynamic>> rows;
  final List<String> columns;
  final List<Widget>? Function(int id)? tableActions;
  final List<int>? disabledIndexes;
  final void Function(int id)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenSize(
        context,
        type: "width",
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.kDefaultPadding,
      ),
      child: AppTableScroller(
        physics: ScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SortableTable(
              rows: rows,
              columns: columns,
              tableActions: tableActions,
              enabledColumns: columns.map((_) => true).toList(),
              disabledIndexes: disabledIndexes,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
