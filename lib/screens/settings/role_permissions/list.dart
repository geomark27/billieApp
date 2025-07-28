/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/settings/role_permissions/add.dart';
import 'package:salepro/screens/settings/role_permissions/edit.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class RolePermissionsListScreen extends StatelessWidget {
  const RolePermissionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Role Permissions List",
      rows: context
          .watch<CommonDataProvider>()
          .roles
          .map((role) => [role.name, role.description])
          .toList(),
      columns: const ["Name", "Description"],
      addPage: const AddRoleScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            icon: Icons.edit,
            screen: EditRoleScreen(
              id: id,
            ),
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            icon: Icons.lock_open_outlined,
            onTap: () {},
          ),
        ];
      },
    );
  }
}
