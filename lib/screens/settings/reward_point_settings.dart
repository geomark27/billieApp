/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: reward_point_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class RewardPointSettingsScreen extends StatefulWidget {
  const RewardPointSettingsScreen({super.key});

  @override
  State<RewardPointSettingsScreen> createState() =>
      _RewardPointSettingsScreenState();
}

class _RewardPointSettingsScreenState extends State<RewardPointSettingsScreen> {
  bool? activeRewardPoint = true;
  late TextEditingController soldAmountPerPointController;
  late TextEditingController minAmountToGetPointController;
  late TextEditingController pointExpiryDurationController;
  String? durationType = "years";

  @override
  void initState() {
    super.initState();
    soldAmountPerPointController = TextEditingController();
    minAmountToGetPointController = TextEditingController();
    pointExpiryDurationController = TextEditingController();
  }

  @override
  void dispose() {
    soldAmountPerPointController.dispose();
    minAmountToGetPointController.dispose();
    pointExpiryDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Reward Point Settings",
      onSubmit: () {},
      children: [
        AppCheckBox(
          hintText: "Active Reward Point",
          value: activeRewardPoint!,
          onChanged: (value) {
            setState(() {
              activeRewardPoint = value;
            });
          },
        ),
        AppInput(
          hintText: "Sold amount per point",
          controller: soldAmountPerPointController,
          keyboardType: TextInputType.number,
          info:
              "This means how much point customer will get according to sold amount. For example, if you put 100 then for every 100 dollar spent customer will get one point as reward.",
        ),
        AppInput(
          hintText: "Minimum Sold amount to get point",
          controller: minAmountToGetPointController,
          keyboardType: TextInputType.number,
          info:
              "For example, if you put 100 then customer will only get point after spending 100 dollar or more.",
        ),
        AppInput(
          hintText: "Point Expiry Duration",
          controller: pointExpiryDurationController,
          keyboardType: TextInputType.number,
        ),
        AppSelect(
          hintText: "Duration Type",
          items: const [
            {"label": "Years", "value": "years"},
            {"label": "Months", "value": "months"},
          ],
          value: durationType,
          onChange: (value) {
            setState(() {
              durationType = value!;
            });
          },
        )
      ],
    );
  }
}
