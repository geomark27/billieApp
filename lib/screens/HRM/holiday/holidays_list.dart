/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: holidays_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/HRM/holiday/add_holiday.dart';
import 'package:salepro/widgets/list.dart';

class HolidaysListScreen extends StatelessWidget {
  const HolidaysListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Holidays List",
      rows: [],
      columns: [],
      addPage: AddHolidayScreen(),
    );
  }
}
