/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: app_table_scroller
*/

import 'package:flutter/material.dart';

class AppTableScroller extends StatelessWidget {
  final Widget child;
  final ScrollController controller;
  final ScrollPhysics? physics;

  const AppTableScroller({
    super.key,
    required this.child,
    required this.controller,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        controller: controller,
        physics: physics ?? AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: child,
      ),
    );
  }
}
