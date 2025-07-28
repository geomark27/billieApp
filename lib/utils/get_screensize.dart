/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: get_screensize
*/

import 'package:flutter/material.dart';

double getScreenSize(BuildContext context, {String type = "height"}) {
  if (type == "height") {
    return MediaQuery.of(context).size.height;
  } else {
    return MediaQuery.of(context).size.width;
  }
}
