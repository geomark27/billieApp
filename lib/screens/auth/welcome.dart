/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: welcome
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/hero_tags.dart';
import 'package:salepro/constants/keys.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/auth/login.dart';
import 'package:salepro/screens/auth/setup_app.dart';
import 'package:salepro/screens/home.dart';
import 'package:salepro/utils/get_app_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    getAppData();
  }

  Future<void> getAppData() async {
    await Provider.of<CommonDataProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 2),
        () async {
          await getAppData();

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String? apiUrl = prefs.getString(AppKeys.saleproInstallURL);
          String? spToken = prefs.getString(AppKeys.saleproSetupToken);

          if (spToken != null) {
            // ignore: use_build_context_synchronously
            if (Provider.of<CommonDataProvider>(context, listen: false).user !=
                null) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const HomeScreen(),
                ),
              );
            } else {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const LoginScreen(),
                ),
              );
            }
          } else {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const SetupScreen(),
              ),
            );
          }
        },
      ),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.authGradientColors(context),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: AppHeroTags.appLogo,
                    child: Image.asset(
                      getAppLogo(context)!,
                      height: AppSpacing.kDefaultPadding * 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
