/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: forget_password
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/hero_tags.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/screens/auth/login.dart';
import 'package:salepro/utils/get_app_logo.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/widgets/button.dart';
import 'package:salepro/widgets/input.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: AppHeroTags.appLogo,
                  child: Image.asset(
                    getAppLogo(context)!,
                    height: AppSpacing.kDefaultPadding * 3,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.kDefaultPadding,
                ),
                Text(
                  "Change Your Password",
                  style: TextStyle(
                    fontSize: AppSpacing.kDefaultPadding * 1.5,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: useThemeMode(
                      context,
                      dark: getThemeColor(context)
                          ?.shade50
                          .withValues(alpha: 0.7),
                      light: getThemeColor(context)
                          ?.shade900
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.kDefaultPadding * 3.5,
                ),
                AppInput(
                  controller: emailController,
                  hintText: "Email Address",
                  icon: HeroIcons.envelope,
                  keyboardType: TextInputType.emailAddress,
                  fancy: true,
                ),
                const SizedBox(
                  height: AppSpacing.kDefaultPadding * 3,
                ),
                AppButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const LoginScreen(),
                      ),
                    );
                  },
                  title: "Submit",
                ),
                const SizedBox(
                  height: AppSpacing.kDefaultPadding * 4,
                ),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: AppSpacing.kDefaultPadding * 0.8,
                          fontWeight: FontWeight.w600,
                          color: useThemeMode(
                            context,
                            light: getThemeColor(context)
                                ?.shade900
                                .withValues(alpha: 0.6),
                            dark: getThemeColor(context)
                                ?.shade50
                                .withValues(alpha: 0.6),
                          ),
                          fontFamily: getThemeFont(context),
                        ),
                        text: "Back to ",
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              height: 1.2,
                              color: useThemeMode(
                                context,
                                light: getThemeColor(context)?.shade900,
                                dark: getThemeColor(context)?.shade100,
                              ),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.kDefaultPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
