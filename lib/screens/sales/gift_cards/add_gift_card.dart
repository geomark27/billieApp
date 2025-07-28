/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_gift_card
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/input.dart' as ip;
import 'package:salepro/widgets/select.dart';

class AddGiftCardScreen extends StatefulWidget {
  const AddGiftCardScreen({super.key});

  @override
  State<AddGiftCardScreen> createState() => _AddGiftCardScreenState();
}

class _AddGiftCardScreenState extends State<AddGiftCardScreen> {
  late TextEditingController cardNumberController;
  late TextEditingController amountController;
  bool useUserList = false;
  String? user;
  String? customer;
  late TextEditingController expiryDateController;

  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController();
    amountController = TextEditingController();
    expiryDateController = TextEditingController();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    amountController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(title: "Add Gift Card", onSubmit: () {}, children: [
      AppInput(
        hintText: "Card No",
        controller: cardNumberController,
        keyboardType: TextInputType.number,
        actionIcon: FontAwesomeIcons.rotate,
        actionIconProvider: ip.InputIcon.fontAwesomeIcon,
        onAction: () {},
      ),
      AppInput(
        hintText: "Amount",
        controller: amountController,
        keyboardType: TextInputType.number,
      ),
      AppCheckBox(
        hintText: "User List",
        value: useUserList,
        onChanged: (value) {
          setState(() {
            useUserList = value!;
          });
        },
      ),
      AnimatedCrossFade(
        firstChild: Column(
          children: generateInputGroups(
            [
              AppSelect(
                hintText: "Customer",
                items: const [],
                onChange: (value) {
                  setState(() {
                    customer = value!;
                  });
                },
                enableFilter: false,
                enableSearch: false,
              ),
            ],
          ),
        ),
        secondChild: Column(
          children: generateInputGroups(
            [
              AppSelect(
                hintText: "User",
                items: const [],
                onChange: (value) {
                  setState(() {
                    user = value!;
                  });
                },
                enableFilter: false,
                enableSearch: false,
              ),
            ],
          ),
        ),
        crossFadeState:
            useUserList ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(
          seconds: 1,
        ),
      ),
      AppDatePicker(
        hintText: "Expired Date",
        value: DateTime.now(),
        controller: expiryDateController,
      ),
    ]);
  }
}
