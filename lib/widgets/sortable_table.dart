/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sortable_table
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/widgets/text_button.dart';

class SortableTable extends StatefulWidget {
  const SortableTable({
    super.key,
    required this.rows,
    required this.columns,
    this.tableActions,
    this.enabledColumns,
    this.dataRowHeight,
    this.disabledIndexes,
    this.onTap,
  });

  final List<List<dynamic>> rows;
  final List<String> columns;
  final List<Widget>? Function(int id)? tableActions;
  final List? enabledColumns;
  final double? dataRowHeight;
  final List<int>? disabledIndexes;
  final void Function(int id)? onTap;

  @override
  State<SortableTable> createState() => _SortableTableState();
}

class _SortableTableState extends State<SortableTable> {
  late List<List<dynamic>> filteredRows;

  int? sortColumnIndex;

  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    filteredRows = widget.rows;
  }

  @override
  void didUpdateWidget(covariant SortableTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rows != widget.rows) {
      setState(() {
        filteredRows = widget.rows;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowMinHeight: widget.dataRowHeight ?? AppSpacing.kDefaultPadding * 4,
      dataRowMaxHeight: widget.dataRowHeight ?? AppSpacing.kDefaultPadding * 4,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: widget.tableActions != null
          ? getColumns(
              [...widget.columns, "Manage"],
              tableActions: widget.tableActions,
              enabledColumns: widget.enabledColumns,
            )
          : getColumns(
              widget.columns,
              enabledColumns: widget.enabledColumns,
            ),
      rows: widget.tableActions != null
          ? getRows(
              filteredRows,
              widget.rows,
              tableActions: widget.tableActions,
              enabledColumns: widget.enabledColumns,
              disabledIndexes: widget.disabledIndexes,
              onTap: widget.onTap,
            )
          : getRows(
              filteredRows,
              widget.rows,
              enabledColumns: widget.enabledColumns,
              onTap: widget.onTap,
            ),
    );
  }

  List<DataColumn> getColumns(
    List<String> columns, {
    List<Widget>? Function(int id)? tableActions,
    List? enabledColumns,
  }) =>
      columns
          .map(
            (String column) => column.toLowerCase() != "manage" &&
                    enabledColumns?[columns.indexOf(column)]
                ? DataColumn(
                    label: Text(
                      column,
                      style: const TextStyle(
                        fontSize: AppSpacing.kDefaultPadding,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSort: onSort,
                  )
                : column.toLowerCase() == "manage"
                    ? DataColumn(
                        label: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: tableActions != null
                                  ? AppSpacing.kDefaultPadding
                                  : 0),
                          child: Text(
                            column,
                            style: const TextStyle(
                              fontSize: AppSpacing.kDefaultPadding,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onSort: onSort,
                      )
                    : const DataColumn(
                        label: SizedBox(),
                      ),
          )
          .toList();

  List<DataRow> getRows(
    List<List<dynamic>> rows,
    List<List<dynamic>> originalRows, {
    List<Widget>? Function(int id)? tableActions,
    List? enabledColumns,
    List? disabledIndexes,
    void Function(int id)? onTap,
  }) =>
      rows.map((row) {
        return DataRow(
          cells: tableActions != null
              ? [
                  ...getCells(
                    row,
                    enabledColumns,
                    onTap: () {
                      if (onTap != null) {
                        onTap(
                          originalRows.indexWhere(
                            (r) => r.toString() == row.toString(),
                          ),
                        );
                      }
                    },
                  ),
                  DataCell(
                    disabledIndexes != null &&
                            disabledIndexes.contains(rows.indexOf(row))
                        ? Container()
                        : Row(
                            children: tableActions(
                              originalRows.indexWhere(
                                (r) => r.toString() == row.toString(),
                              ),
                            )!,
                          ),
                  ),
                ]
              : getCells(
                  row,
                  enabledColumns,
                  onTap: () {
                    if (onTap != null) {
                      onTap(
                        originalRows.indexWhere(
                          (r) => r.toString() == row.toString(),
                        ),
                      );
                    }
                  },
                ),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells, enabledColumns,
          {VoidCallback? onTap}) =>
      cells.map((data) {
        if (enabledColumns[cells.indexOf(data)]) {
          if (data.runtimeType.toString().toLowerCase().contains("map")) {
            switch (data['type']) {
              case 'avatar':
                return DataCell(
                  data['value'] != null
                      ? CachedNetworkImage(
                          imageUrl: data['value'],
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            foregroundImage: imageProvider,
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Center(child: const Icon(Icons.error)),
                        )
                      : Center(
                          child: const Icon(
                            Icons.error,
                          ),
                        ),
                  onTap: onTap,
                );
              case 'image':
                return DataCell(
                  data['value'] != null
                      ? CachedNetworkImage(
                          imageUrl: data['value'],
                          imageBuilder: (context, imageProvider) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.kDefaultPadding * 0.2,
                            ),
                            child: Container(
                              width: AppSpacing.kDefaultPadding * 4,
                              height: AppSpacing.kDefaultPadding * 4,
                              margin: const EdgeInsets.all(
                                AppSpacing.kDefaultPadding * 0.2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppSpacing.kDefaultPadding * 0.25),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Center(
                            child: const Icon(
                              Icons.error,
                            ),
                          ),
                        )
                      : Center(
                          child: const Icon(
                            Icons.error,
                          ),
                        ),
                  onTap: onTap,
                );
              case "blank":
                return DataCell(
                  Container(),
                  onTap: onTap,
                );
              case "custom":
                return DataCell(
                  data['child'],
                  onTap: onTap,
                );
              default:
                return DataCell(
                  Container(),
                  onTap: onTap,
                );
            }
          }
          return DataCell(
            data != null ? Text('$data') : const Text("No Data"),
            onTap: onTap,
          );
        } else {
          return DataCell(
            SizedBox(),
            onTap: onTap,
          );
        }
      }).toList();

  void onSort(int columnIndex, bool ascending) {
    filteredRows.sort((row1, row2) => compareString(
        ascending, '${row1[columnIndex]}', '${row2[columnIndex]}'));

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

class TableActionIcon extends StatelessWidget {
  const TableActionIcon(
      {super.key,
      required this.iconType,
      this.icon,
      this.lightColor,
      this.darkColor,
      this.onTap,
      this.screen});
  final String iconType;
  final dynamic icon;
  final Color? lightColor;
  final Color? darkColor;
  final VoidCallback? onTap;
  final Widget? screen;

  @override
  Widget build(BuildContext context) {
    switch (iconType) {
      case "heroIcon":
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding * 0.25,
          ),
          child: AppTextButton(
            onTap: () {
              if (onTap == null && screen != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => screen!,
                  ),
                );
              } else if (onTap != null && screen == null) {
                onTap!();
              }
            },
            child: HeroIcon(
              icon,
              color: useThemeMode(
                context,
                dark: darkColor ?? getThemeColor(context)!.shade300,
                light: lightColor ?? getThemeColor(context)!.shade600,
              ),
              size: AppSpacing.kDefaultPadding * 2,
            ),
          ),
        );
      case "fontAwesomeIcon":
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding * 0.25,
          ),
          child: AppTextButton(
            onTap: () {
              if (onTap == null && screen != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => screen!,
                  ),
                );
              } else if (onTap != null && screen == null) {
                onTap!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(
                AppSpacing.kDefaultPadding * 0.2,
              ),
              child: Icon(
                icon,
                color: useThemeMode(
                  context,
                  dark: darkColor ?? getThemeColor(context)!.shade300,
                  light: lightColor ?? getThemeColor(context)!.shade600,
                ),
                size: AppSpacing.kDefaultPadding * 1.7,
              ),
            ),
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.kDefaultPadding * 0.25,
          ),
          child: AppTextButton(
            onTap: () {
              if (onTap == null && screen != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => screen!,
                  ),
                );
              } else if (onTap != null && screen == null) {
                onTap!();
              }
            },
            child: Icon(
              icon,
              color: useThemeMode(
                context,
                light: lightColor ?? getThemeColor(context)!.shade600,
                dark: darkColor ?? getThemeColor(context)!.shade300,
              ),
              size: AppSpacing.kDefaultPadding * 2,
            ),
          ),
        );
    }
  }
}
