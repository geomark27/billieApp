/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/settings/barcode_settings/add.dart';
import 'package:salepro/widgets/list.dart';

class BarcodeSettingsScreen extends StatelessWidget {
  const BarcodeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Barcode Settings",
      rows: [],
      columns: [],
      addPage: AddBarcodeStickerSettingScreen(),
    );
  }
}
