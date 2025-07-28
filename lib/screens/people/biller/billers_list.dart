/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: billers_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/biller/add_biller.dart';
import 'package:salepro/screens/people/biller/edit_biller.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class BillersListScreen extends StatefulWidget {
  const BillersListScreen({super.key});

  @override
  State<BillersListScreen> createState() => _BillersListScreenState();
}

class _BillersListScreenState extends State<BillersListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getBillers();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Billers List",
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
          .billers
          .map(
            (biller) => [
              {"type": "image", "value": biller.image},
              biller.name,
              biller.companyName,
              biller.vatNumber,
              biller.email,
              biller.phoneNumber,
              biller.address,
            ],
          )
          .toList(),
      columns: const [
        "Image",
        "Name",
        "Company Name",
        "VAT Number",
        "Email",
        "Phone Number",
        "Address",
      ],
      addPage: const AddBillerScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditBillerScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () {},
            icon: Icons.delete,
            lightColor: AppColors.roseSwatch.shade600,
            darkColor: AppColors.roseSwatch.shade300,
          ),
        ];
      },
    );
  }
}
