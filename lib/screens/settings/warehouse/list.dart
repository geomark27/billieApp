/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/settings/warehouse/api/warehouse.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/warehouse/add.dart';
import 'package:salepro/screens/settings/warehouse/edit.dart';
import 'package:salepro/screens/settings/warehouse/import.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class WarehouseListScreen extends StatefulWidget {
  const WarehouseListScreen({super.key});

  @override
  State<WarehouseListScreen> createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  bool requirePagination = false;

  @override
  Widget build(BuildContext context) {
    Future<Data> fetchData(BuildContext context) async {
      return await context.read<CommonDataProvider>().getWareHouses();
    }

    Future<void> deleteWarehouse(int id, BuildContext context) async {
      Loading.start(context);
      await WarehouseAPI.delete(id, context.read<CommonDataProvider>().token);
      // ignore: use_build_context_synchronously
      Loading.stop(context);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const WarehouseListScreen(),
        ),
      );
    }

    return ListScreen(
      title: "Warehouse List",
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
          .wareHouses
          .map(
            (warehouse) => [
              warehouse.name,
              warehouse.phone,
              warehouse.email,
              warehouse.address,
              warehouse.numberOfProducts,
              warehouse.stockQuantity,
            ],
          )
          .toList(),
      columns: const [
        "Name",
        "Phone",
        "Email",
        "Address",
        "Number of Product",
        "Stock Quantity",
      ],
      addPage: const AddWarehouseScreen(),
      importPage: const ImportWarehousesScreen(),
      importTooltip: "Import Warehouse",
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditWarehouseScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              deleteWarehouse(
                context.read<CommonDataProvider>().wareHouses[id].id,
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
