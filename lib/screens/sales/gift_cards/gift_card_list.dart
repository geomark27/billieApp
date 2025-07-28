/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: gift_card_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/sales/gift_cards/add_gift_card.dart';
import 'package:salepro/widgets/list.dart';

class GiftCardListScreen extends StatelessWidget {
  const GiftCardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Gift Cards List",
      rows: [],
      columns: [],
      addPage: AddGiftCardScreen(),
    );
  }
}
