/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_coupon
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/input.dart' as ip;
import 'package:salepro/widgets/select.dart';

class AddCouponScreen extends StatefulWidget {
  const AddCouponScreen({super.key});

  @override
  State<AddCouponScreen> createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  late TextEditingController couponCodeController;
  String type = "percentage";
  late TextEditingController amountController;
  late TextEditingController minAmountController;
  late TextEditingController qtyController;
  late TextEditingController expiryDateController;

  @override
  void initState() {
    super.initState();
    couponCodeController = TextEditingController();
    amountController = TextEditingController();
    minAmountController = TextEditingController();
    qtyController = TextEditingController();
    expiryDateController = TextEditingController();
  }

  @override
  void dispose() {
    couponCodeController.dispose();
    amountController.dispose();
    minAmountController.dispose();
    qtyController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(title: "Add Coupon", onSubmit: () {}, children: [
      AppInput(
        hintText: "Coupon Code",
        controller: couponCodeController,
        keyboardType: TextInputType.number,
        actionIcon: FontAwesomeIcons.rotate,
        actionIconProvider: ip.InputIcon.fontAwesomeIcon,
        onAction: () {},
      ),
      AppSelect(
        hintText: "Type",
        value: type,
        items: const [
          {
            "label": "Percentage",
            "value": "percentage",
          },
          {
            "label": "Fixed Amount",
            "value": "fixed_amount",
          },
        ],
        onChange: (value) {
          setState(() {
            type = value!;
          });
        },
        enableFilter: false,
        enableSearch: false,
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox(
          width: 0,
          height: 0,
        ),
        secondChild: Column(
          children: generateInputGroups(
            [
              AppInput(
                hintText: "Minimum Amount",
                controller: minAmountController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        crossFadeState: type == "percentage"
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(
          seconds: 1,
        ),
      ),
      AppInput(
        hintText: "Amount",
        controller: amountController,
        keyboardType: TextInputType.number,
        actionIcon: type == "percentage" ? FontAwesomeIcons.percent : FontAwesomeIcons.dollarSign,
        actionIconProvider: ip.InputIcon.fontAwesomeIcon,
        onAction: () {},
      ),
      AppInput(
        hintText: "Qty",
        controller: qtyController,
        keyboardType: TextInputType.number,
      ),
      AppDatePicker(
        hintText: "Expired Date",
        value: DateTime.now(),
        controller: expiryDateController,
      ),
    ]);
  }
}
