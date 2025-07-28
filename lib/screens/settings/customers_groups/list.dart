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
import 'package:salepro/screens/settings/customers_groups/add.dart';
import 'package:salepro/screens/settings/customers_groups/api/customer_groups.dart';
import 'package:salepro/screens/settings/customers_groups/import.dart';
import 'package:salepro/screens/settings/customers_groups/edit.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class CustomerGroupsListScreen extends StatefulWidget {
  const CustomerGroupsListScreen({super.key});

  @override
  State<CustomerGroupsListScreen> createState() =>
      _CustomerGroupsListScreenState();
}

class _CustomerGroupsListScreenState extends State<CustomerGroupsListScreen> {
  bool requirePagination = false;
  Message? message;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getCustomerGroups();
  }

  Future<void> deleteCustomerGroup(int id, BuildContext context) async {
    Loading.start(context);
    message = await CustomerGroupAPI.delete(
      id,
      context.read<CommonDataProvider>().token,
    );
    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const CustomerGroupsListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Customer Groups",
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
          .customerGroups
          .map(
            (customerGroup) => [
              customerGroup.name,
              customerGroup.percentage,
            ],
          )
          .toList(),
      columns: const [
        "Name",
        "Percentage",
      ],
      addPage: const AddCustomerGroupScreen(),
      importPage: const ImportCustomerGroupsScreen(),
      importTooltip: "Import Customer Groups",
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditCustomerGroupScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteCustomerGroup(
                context.read<CommonDataProvider>().customerGroups[id].id,
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
