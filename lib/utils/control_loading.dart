/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: control_loading
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/theme_provider.dart';

class Loading {
  static void start(BuildContext context) {
    context.read<ThemeProvider>().setLoading(true);
  }

  static void stop(BuildContext context) {
    context.read<ThemeProvider>().setLoading(false);
  }
}
