/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: login
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salepro/api/auth.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/hero_tags.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/auth/forget_password.dart';
import 'package:salepro/screens/auth/register.dart';
import 'package:salepro/screens/home.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/get_app_logo.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/app_loader.dart';
import 'package:salepro/widgets/button.dart';
import 'package:salepro/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    late TextEditingController userNameController;
    late TextEditingController passwordController;
    Message? message;

    @override
    void initState() {
        super.initState();
        userNameController = TextEditingController();
        passwordController = TextEditingController();
    }

    @override
    void dispose() {
        userNameController.dispose();
        passwordController.dispose();
        super.dispose();
    }

    Future<void> handleSubmit(BuildContext context) async {
        Loading.start(context);

        message = await login(
            {
                "name": userNameController.text,
                "password": passwordController.text,
            },
        );
        setState(() {});

        // ignore: use_build_context_synchronously
        Loading.stop(context);

        if (message?.success == true) {
            await OneSignal.logout();
            await OneSignal.login(message!.data!['user']['id'].toString());
            showSnackBar(
                message?.message,
                context,
            );

            await context.read<CommonDataProvider>().getData();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (ctx) => const HomeScreen(),
                ),
            );
        } else {
            showSnackBar(
                message?.message,
                // ignore: use_build_context_synchronously
                context,
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        body: AppLoader(
            child: Container(
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
                    mainAxisSize: MainAxisSize.max,
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
                        "Login to Your Account",
                        style: TextStyle(
                        fontSize: AppSpacing.kDefaultPadding * 1.5,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: useThemeMode(
                            context,
                            light: getThemeColor(context)
                                ?.shade900
                                .withValues(alpha: 0.7),
                            dark: getThemeColor(context)
                                ?.shade50
                                .withValues(alpha: 0.7),
                        ),
                        ),
                    ),
                    const SizedBox(
                        height: AppSpacing.kDefaultPadding * 3.5,
                    ),
                    AppInput(
                        controller: userNameController,
                        hintText: "User Name",
                        icon: HeroIcons.user,
                        fancy: true,
                        errorLine: message?.errors?['name'],
                    ),
                    const SizedBox(
                        height: AppSpacing.kDefaultPadding,
                    ),
                    AppInput(
                        controller: passwordController,
                        hintText: "Password",
                        icon: HeroIcons.key,
                        password: true,
                        fancy: true,
                        errorLine: message?.errors?['password'],
                    ),
                    const SizedBox(
                        height: AppSpacing.kDefaultPadding,
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                        right: AppSpacing.kDefaultPadding * 2,
                        ),
                        width: double.infinity,
                        child: InkWell(
                        onTap: () {
                            Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => const ForgetPasswordScreen(),
                            ),
                            );
                        },
                        child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                            style: TextStyle(
                                fontSize: AppSpacing.kDefaultPadding * 0.8,
                                fontWeight: FontWeight.w600,
                                color: useThemeMode(
                                context,
                                dark: getThemeColor(context)
                                    ?.shade50
                                    .withValues(alpha: 0.6),
                                light: getThemeColor(context)
                                    ?.shade900
                                    .withValues(alpha: 0.6),
                                ),
                                fontFamily: getThemeFont(context),
                            ),
                            children: [
                                TextSpan(
                                text: "Forgot Password?",
                                style: TextStyle(
                                    height: 1.2,
                                    color: useThemeMode(
                                    context,
                                    dark: getThemeColor(context)?.shade100,
                                    light: getThemeColor(context)?.shade900,
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
                        height: AppSpacing.kDefaultPadding * 3,
                    ),
                    AppButton(
                        onPressed: () {
                        handleSubmit(context);
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
                                builder: (ctx) => const RegisterScreen(),
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
                                dark: getThemeColor(context)
                                    ?.shade50
                                    .withValues(alpha: 0.6),
                                light: getThemeColor(context)
                                    ?.shade900
                                    .withValues(alpha: 0.6),
                                ),
                                fontFamily: getThemeFont(context),
                            ),
                            text: "Don't have an account? ",
                            children: [
                                TextSpan(
                                text: "Register Now",
                                style: TextStyle(
                                    height: 1.2,
                                    color: useThemeMode(
                                    context,
                                    dark: getThemeColor(context)?.shade100,
                                    light: getThemeColor(context)?.shade900,
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
        ),
        );
    }
}
