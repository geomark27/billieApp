/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: accounts_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/accounting/add_account.dart';
import 'package:salepro/screens/accounting/api/accounts.dart';
import 'package:salepro/screens/accounting/edit_account.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class AccountsListScreen extends StatefulWidget {
  const AccountsListScreen({super.key});

  @override
  State<AccountsListScreen> createState() => _AccountsListScreenState();
}

class _AccountsListScreenState extends State<AccountsListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getAccounts();
  }

  Future<void> deleteAccount(int id, BuildContext context) async {
    Loading.start(context);
    await AccountsAPI.delete(id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const AccountsListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Accounts List",
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
      rows: [
        ...context.watch<CommonDataProvider>().accounts.map(
              (account) => [
                account.accountNo,
                account.name,
                account.initialBalance.toStringAsFixed(2),
                {
                  "type": "custom",
                  "child": Switch.adaptive(
                    activeColor: getThemeColor(context),
                    value: account.isDefault ?? false,
                    onChanged: (bool? val) {},
                  ),
                },
                account.note,
              ],
            ),
        [
          {
            "type": "custom",
            "child": Text(
              "Total",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.kDefaultPadding * 1.2,
              ),
            )
          },
          {
            "type": "blank",
          },
          {
            "type": "custom",
            "child": Text(
              context
                  .watch<CommonDataProvider>()
                  .accounts
                  .fold(
                    0.00,
                    (total, account) => total += account.initialBalance,
                  )
                  .toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.kDefaultPadding * 1.2,
              ),
            )
          },
          {
            "type": "blank",
          },
          {
            "type": "blank",
          },
        ]
      ],
      columns: [
        "Account No",
        "Name",
        "Initial Balance",
        "Default",
        "Note",
      ],
      addPage: AddAccountScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditAccountScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteAccount(
                context.read<CommonDataProvider>().accounts[id].id,
                context,
              );
            },
            icon: Icons.delete,
            lightColor: AppColors.roseSwatch.shade600,
            darkColor: AppColors.roseSwatch.shade300,
          ),
        ];
      },
      disabledIndexes: [
        context.watch<CommonDataProvider>().accounts.length,
      ],
    );
  }
}
