/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: form_screen
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/app_loader.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/form.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.children,
  });

  final String title;
  final VoidCallback onSubmit;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: const AppDrawer(),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AppForm(
              onSubmit: onSubmit,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
