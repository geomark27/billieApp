/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: coupon_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/sales/coupons/add_coupon.dart';
import 'package:salepro/widgets/list.dart';

class CouponListScreen extends StatelessWidget {
  const CouponListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Coupon List",
      rows: [],
      columns: [],
      addPage: AddCouponScreen(),
    );
  }
}
