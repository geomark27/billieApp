/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customers_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/customers/add_customer.dart';
import 'package:salepro/screens/people/customers/api/customers.dart';
import 'package:salepro/screens/people/customers/edit_customer.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class CustomersListScreen extends StatefulWidget {
  const CustomersListScreen({super.key});

  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getCustomers();
  }

  Future<void> deleteCustomer(int id, BuildContext context) async {
    Loading.start(context);
    await CustomerAPI.delete(
      id,
      context.read<CommonDataProvider>().token,
    );
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const CustomersListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Customers List",
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
      loadNewPage: (count) async {
        await context.read<CommonDataProvider>().getCustomersPaginated(count);
      },
      dataRowHeight: AppSpacing.kDefaultPadding * 8,
      rows: context
          .watch<CommonDataProvider>()
          .customers
          .map(
            (customer) => [
              customer.customerGroup?.name,
              "${customer.customerName}\n${customer.phoneNumber ?? "No Phone Number Provided"}\n${customer.taxNo ?? "No Tax Number Provided"}\n${customer.address ?? "No Address Provided"}\n${customer.city ?? "No City Provided"}\n${customer.country ?? "No Country Provided"}",
              "N/A",
              customer.points,
              customer.deposit?.toStringAsFixed(2),
              customer.totalDue?.toStringAsFixed(2),
            ],
          )
          .toList(),
      columns: [
        "Customer Group",
        "Customer Details",
        "Discount Plan",
        "Reward Points",
        "Deposited Balance",
        "Total Due",
      ],
      addPage: AddCustomerScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditCustomerScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteCustomer(
                context.read<CommonDataProvider>().customers[id].id,
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
