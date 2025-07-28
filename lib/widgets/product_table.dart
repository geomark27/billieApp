/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_table
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/widgets/app_table_scroller.dart';
import 'package:salepro/widgets/select.dart';
import 'package:salepro/widgets/sortable_table.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({
    super.key,
    required this.rows,
    required this.columns,
    this.tableActions,
    required this.onChange,
    required this.value,
    this.onTap,
    this.disabledIndexes,
  });

  final String value;
  final List<List<dynamic>> rows;
  final List<String> columns;
  final List<Widget>? Function(int id)? tableActions;
  final void Function(String? value) onChange;
  final List<int>? disabledIndexes;
  final void Function(int id)? onTap;

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  @override
  void initState() {
    super.initState();
    context.read<CommonDataProvider>().getFullProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          AppSelect(
            hintText: "Product",
            value: widget.value,
            items: context
                .read<CommonDataProvider>()
                .selectProductsData
                .map(
                  (p) => ({
                    "label": "${p['value']} - ${p['label']}",
                    "value": p['value']
                  }),
                )
                .toList(),
            onChange: widget.onChange,
            prefix: const Icon(
              FontAwesomeIcons.barcode,
            ),
            enableFilter: true,
            enableSearch: true,
          ),
          Container(
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
                    rows: widget.rows,
                    columns: widget.columns,
                    tableActions: widget.tableActions,
                    enabledColumns: widget.columns.map((_) => true).toList(),
                    disabledIndexes: widget.disabledIndexes,
                    onTap: widget.onTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
