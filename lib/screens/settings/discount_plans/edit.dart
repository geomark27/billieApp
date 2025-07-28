/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/screens/settings/discount_plans/api/discount_plans.dart';
import 'package:salepro/screens/settings/discount_plans/list.dart';
import 'package:salepro/screens/settings/discount_plans/models/discount_plan.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/app_table.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';
import 'package:salepro/widgets/sortable_table.dart';

class EditDiscountPlanScreen extends StatefulWidget {
  const EditDiscountPlanScreen({super.key, required this.id});

  final int id;

  @override
  State<EditDiscountPlanScreen> createState() => _EditDiscountPlanScreenState();
}

class _EditDiscountPlanScreenState extends State<EditDiscountPlanScreen> {
  late DiscountPlan discountPlan;
  late TextEditingController nameController;
  List<Customer> customers = [];
  bool? active = true;
  Message? message;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    discountPlan = context.read<CommonDataProvider>().discountPlans[widget.id];
    nameController.text = discountPlan.name;
    setState(() {
      customers = discountPlan.customers;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await DiscountPlansAPI.update(
      discountPlan.id,
      DiscountPlan(
        id: discountPlan.id,
        name: nameController.text,
        customers: customers,
        isActive: active != null && active! ? "1" : "0",
      ),
      context.read<CommonDataProvider>().token,
    );

    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message!.success) {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "success");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const DiscountPlansScreen(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Discount Plan",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppSelect(
          hintText: "Customer",
          items: context.watch<CommonDataProvider>().selectCustomersData,
          onChange: (value) {
            setState(() {
              customers = [
                ...customers,
                context.read<CommonDataProvider>().customers[context
                    .read<CommonDataProvider>()
                    .customers
                    .indexWhere((c) => c.id.toString() == value)]
              ];
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['customer_id'],
        ),
        if (customers.isNotEmpty)
          AppTable(
            rows: customers
                .map((c) => [
                      c.customerName,
                      c.phoneNumber,
                    ])
                .toList(),
            columns: [
              "Name",
              "Phone",
            ],
            tableActions: (id) {
              return [
                TableActionIcon(
                  iconType: NavLink.materialIcon,
                  onTap: () async {
                    setState(() {
                      customers.removeAt(id);
                    });
                  },
                  icon: Icons.delete,
                  lightColor: AppColors.roseSwatch.shade600,
                  darkColor: AppColors.roseSwatch.shade300,
                ),
              ];
            },
          ),
        AppCheckBox(
          hintText: "Active",
          value: active!,
          onChanged: (value) {
            setState(() {
              active = value!;
            });
          },
          errorLine: message?.errors?['is_active'],
        ),
      ],
    );
  }
}
