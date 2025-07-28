/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: suppliers_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/suppliers/add_supplier.dart';
import 'package:salepro/screens/people/suppliers/api/suppliers.dart';
import 'package:salepro/screens/people/suppliers/edit_supplier.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class SuppliersListScreen extends StatefulWidget {
  const SuppliersListScreen({super.key});

  @override
  State<SuppliersListScreen> createState() => _SuppliersListScreenState();
}

class _SuppliersListScreenState extends State<SuppliersListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getSuppliers();
  }

  Future<void> deleteSupplier(int id, BuildContext context) async {
    Loading.start(context);
    await SuppliersAPI.delete(id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const SuppliersListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Suppliers List",
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
      requirePagination: requirePagination,
      dataRowHeight: AppSpacing.kDefaultPadding * 9,
      rows: context
          .watch<CommonDataProvider>()
          .suppliers
          .map(
            (supplier) => [
              {"type": "image", "value": supplier.image},
              "${supplier.name}\n${supplier.companyName ?? ""}\n${supplier.vatNumber}\n${supplier.email}\n${supplier.phoneNumber}\n${supplier.address}, ${supplier.city}, ${supplier.country}",
              supplier.totalDue,
            ],
          )
          .toList(),
      columns: [
        "Image",
        "Supplier Details",
        "Total Due",
      ],
      addPage: AddSupplierScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditSupplierScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteSupplier(
                context.read<CommonDataProvider>().suppliers[id].id,
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
