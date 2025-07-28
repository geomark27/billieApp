/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: setup_app
*/

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/api/auth.dart';
import 'package:salepro/api/client.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/hero_tags.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/auth/login.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/get_app_logo.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/get_theme_font.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/app_loader.dart';
import 'package:salepro/widgets/button.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/input.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  late TextEditingController urlController;
  late TextEditingController keyController;
  bool useDemo = true;
  Message? message;

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController(
      text: defaultApiURL.replaceAll("/api", ""),
    );
    keyController = TextEditingController(text: "000000");
  }

  @override
  void dispose() {
    urlController.dispose();
    keyController.dispose();
    super.dispose();
  }

  Future<void> scanQRCode(BuildContext context) async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.QR,
    );

    List items = code.split('?app_key=');
    if (items.length > 1) {
      setState(() {
        urlController.text = items[0];
        keyController.text = items[1];
      });

      // ignore: use_build_context_synchronously
      await handleSubmit(context);
    }
  }

  Future<void> handleSubmit(BuildContext context) async {
    Loading.start(context);

    message = await setup(
      {
        "install_url": urlController.text.endsWith('/')
            ? urlController.text.substring(
                0,
                urlController.text.length - 1,
              )
            : urlController.text,
        "app_key": keyController.text,
      },
    );
    setState(() {});

    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message?.success == true) {
      showSnackBar(
        message?.message,
        // ignore: use_build_context_synchronously
        context,
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        ),
      );
    } else {
      showSnackBar(
        message?.message,
        // ignore: use_build_context_synchronously
        context,
        type: "error",
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
                    "Connect Server with this App",
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
                    controller: urlController,
                    hintText: "Salepro Installation URL",
                    icon: HeroIcons.server,
                    fancy: true,
                    errorLine: message?.errors?['install_url'],
                    readOnly: useDemo,
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding,
                  ),
                  AppInput(
                    controller: keyController,
                    hintText: "App Key",
                    icon: HeroIcons.key,
                    fancy: true,
                    errorLine: message?.errors?['app_key'],
                    readOnly: useDemo,
                    password: true,
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.kDefaultPadding,
                    ),
                    child: AppCheckBox(
                      hintText: "Use Demo Salepro Details",
                      value: useDemo,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            useDemo = value;
                            if (value) {
                              urlController.text =
                                  defaultApiURL.replaceAll("/api", "");
                              keyController.text = "000000";
                            } else {
                              urlController.text = "";
                              keyController.text = "";
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding * 3,
                  ),
                  AppButton(
                    onPressed: () {
                      handleSubmit(context);
                    },
                    title: "Connect",
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding * 4,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () => scanQRCode(context),
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
                          text: "Facing Problems? ",
                          children: [
                            TextSpan(
                              text: "Scan QR Code",
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
