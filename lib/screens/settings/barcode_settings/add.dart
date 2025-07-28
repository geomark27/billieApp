/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddBarcodeStickerSettingScreen extends StatefulWidget {
  const AddBarcodeStickerSettingScreen({super.key});

  @override
  State<AddBarcodeStickerSettingScreen> createState() =>
      _AddBarcodeStickerSettingScreenState();
}

class _AddBarcodeStickerSettingScreenState
    extends State<AddBarcodeStickerSettingScreen> {
  late TextEditingController settingNameController;
  late TextEditingController settingDescController;
  bool? continuousFeedOrRolls = false;
  late TextEditingController topMarginController;
  late TextEditingController leftMarginController;
  late TextEditingController stickerWidthController;
  late TextEditingController stickerHeightController;
  late TextEditingController paperWidthController;
  late TextEditingController paperHeightController;
  late TextEditingController stickersInOneRowController;
  late TextEditingController distanceBetweenTwoRowsController;
  late TextEditingController distanceBetweenTwoColsController;
  late TextEditingController numberOfStickersPerSheetController;
  bool? setAsDefault = false;

  @override
  void initState() {
    super.initState();
    settingNameController = TextEditingController();
    settingDescController = TextEditingController();
    topMarginController = TextEditingController();
    leftMarginController = TextEditingController();
    stickerWidthController = TextEditingController();
    stickerHeightController = TextEditingController();
    paperWidthController = TextEditingController();
    paperHeightController = TextEditingController();
    stickersInOneRowController = TextEditingController();
    distanceBetweenTwoRowsController = TextEditingController();
    distanceBetweenTwoColsController = TextEditingController();
    numberOfStickersPerSheetController = TextEditingController();
  }

  @override
  void dispose() {
    settingNameController.dispose();
    settingDescController.dispose();
    topMarginController.dispose();
    leftMarginController.dispose();
    stickerWidthController.dispose();
    stickerHeightController.dispose();
    paperWidthController.dispose();
    paperHeightController.dispose();
    stickersInOneRowController.dispose();
    distanceBetweenTwoRowsController.dispose();
    distanceBetweenTwoColsController.dispose();
    numberOfStickersPerSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Barcode Sticker Setting",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Sticker Sheet setting Name",
          controller: settingNameController,
        ),
        AppInput(
          hintText: "Sticker Sheet setting Description",
          controller: settingDescController,
          multiline: true,
        ),
        AppCheckBox(
          hintText: "Continuous feed or rolls",
          value: continuousFeedOrRolls!,
          onChanged: (value) {
            setState(() {
              continuousFeedOrRolls = value;
            });
          },
        ),
        AppInput(
          hintText: "Additional top margin (In Inches)",
          controller: topMarginController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Additional left margin (In Inches)",
          controller: leftMarginController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Width of sticker (In Inches)",
          controller: stickerWidthController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Height of sticker (In Inches)",
          controller: stickerHeightController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Paper width (In Inches)",
          controller: stickerWidthController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Paper height (In Inches)",
          controller: stickerHeightController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Stickers in one row",
          controller: stickersInOneRowController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Stickers in one row",
          controller: stickersInOneRowController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Distance between two rows (In Inches)",
          controller: distanceBetweenTwoRowsController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Distance between two columns (In Inches)",
          controller: distanceBetweenTwoColsController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "No. of Stickers per sheet",
          controller: numberOfStickersPerSheetController,
          keyboardType: TextInputType.number,
        ),
        AppCheckBox(
          hintText: "Set as default",
          value: setAsDefault!,
          onChanged: (value) {
            setState(() {
              setAsDefault = value;
            });
          },
        ),
      ],
    );
  }
}
