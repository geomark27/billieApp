/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: register
*/

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:salepro/api/auth.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/hero_tags.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/models/role.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/auth/customer_details.dart';
import 'package:salepro/screens/auth/login.dart';
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
import 'package:salepro/widgets/select.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController companyNameController;
  String? role = "0";
  String? biller = "0";
  String? warehouse = "0";
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  Map<String, Role> roles = {
    '0': Role(
      id: 0,
      name: "Select Role",
      customerDetailsRequired: 0,
      billerRequired: 0,
      warehouseRequired: 0,
    ),
  };

  late TextEditingController nameController;
  String? customerGroup = "0";
  late TextEditingController taxNumberController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;
  late TextEditingController countryController;
  Message? message;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    companyNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    nameController = TextEditingController();
    taxNumberController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    postalCodeController = TextEditingController();
    countryController = TextEditingController();

    setState(() {
      context.read<CommonDataProvider>().roles.forEach((role) {
        roles[role.id.toString()] = role;
      });
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameController.dispose();
    taxNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();

    super.dispose();
  }

  Future<void> handleSubmit(BuildContext context) async {
    Loading.start(context);
    Map<String, dynamic> customerDetails = {};
    Map<String, dynamic> billerDetails = {};
    Map<String, dynamic> wareHouseDetails = {};

    if (roles[role]?.customerDetailsRequired == 1) {
      customerDetails = {
        "customer_name": nameController.text,
        "customer_group_id": customerGroup,
        "tax_no": taxNumberController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "postal_code": postalCodeController.text,
        "country": countryController.text,
      };
    }
    if (roles[role]?.billerRequired == 1) {
      billerDetails = {
        "biller_id": biller,
      };
    }
    if (roles[role]?.warehouseRequired == 1) {
      wareHouseDetails = {
        "warehouse_id": warehouse,
      };
    }

    message = await register(
      {
        "name": userNameController.text,
        "email": emailController.text,
        "phone_number": phoneController.text,
        "company_name": companyNameController.text,
        "role_id": role!,
        ...customerDetails,
        ...billerDetails,
        ...wareHouseDetails,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      },
    );

    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message?.success == true) {
      if (message?.data?['token'] == null) {
        showSnackBar(
          "${message?.message} Now you have to login...",
          // ignore: use_build_context_synchronously
          context,
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
        );
      } else {
        showSnackBar(
          message?.message,
          // ignore: use_build_context_synchronously
          context,
        );
        // ignore: use_build_context_synchronously
        await context.read<CommonDataProvider>().getData();
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      }
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
                children: [
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding * 5,
                  ),
                  Hero(
                    tag: AppHeroTags.appLogo,
                    child: Image.asset(
                      getAppLogo(context)!,
                      height: AppSpacing.kDefaultPadding * 3,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding * 0.5,
                  ),
                  Text(
                    "Register for a new Account",
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
                    height: AppSpacing.kDefaultPadding * 2.5,
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
                    controller: emailController,
                    hintText: "Email Address",
                    icon: HeroIcons.envelope,
                    keyboardType: TextInputType.emailAddress,
                    fancy: true,
                    errorLine: message?.errors?['email'],
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding,
                  ),
                  AppInput(
                    controller: phoneController,
                    hintText: "Phone Number",
                    icon: HeroIcons.phone,
                    keyboardType: TextInputType.phone,
                    fancy: true,
                    errorLine: message?.errors?['phone_number'],
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding,
                  ),
                  AppInput(
                    controller: companyNameController,
                    hintText: "Company Name",
                    icon: HeroIcons.buildingOffice,
                    fancy: true,
                    errorLine: message?.errors?['company_name'],
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding,
                  ),
                  AppSelect(
                    hintText: "Role",
                    icon: HeroIcons.userGroup,
                    value: role,
                    onChange: (String? value) {
                      setState(() {
                        role = value;
                      });
                    },
                    items: [
                      const {'label': "Select Role*", 'value': "0"},
                      ...context.watch<CommonDataProvider>().selectRolesData
                    ],
                    enableFilter: false,
                    enableSearch: false,
                    fancy: true,
                    errorLine: message?.errors?['role_id'],
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    crossFadeState: roles[role]!.billerRequired == 0
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.kDefaultPadding,
                      ),
                      child: AppSelect(
                        hintText: "Biller",
                        icon: HeroIcons.userCircle,
                        value: role,
                        onChange: (String? value) {
                          setState(() {
                            biller = value;
                          });
                        },
                        items: [
                          const {'label': "Select Biller*", 'value': "0"},
                          ...context
                              .watch<CommonDataProvider>()
                              .selectBillersData
                        ],
                        enableFilter: false,
                        enableSearch: false,
                        fancy: true,
                        errorLine: message?.errors?['biller_id'],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    crossFadeState: roles[role]!.warehouseRequired == 0
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.kDefaultPadding,
                      ),
                      child: AppSelect(
                        hintText: "Warehouse",
                        icon: HeroIcons.buildingOffice,
                        value: role,
                        onChange: (String? value) {
                          setState(() {
                            warehouse = value;
                          });
                        },
                        items: [
                          const {'label': "Select Warehouse*", 'value': "0"},
                          ...context
                              .watch<CommonDataProvider>()
                              .selectWarehousesData
                        ],
                        enableFilter: false,
                        enableSearch: false,
                        fancy: true,
                        errorLine: message?.errors?['warehouse_id'],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    crossFadeState: roles[role]!.customerDetailsRequired == 0
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.kDefaultPadding,
                      ),
                      child: CustomerDetails(
                        nameController: nameController,
                        customerGroup: customerGroup!,
                        customerGroups: [
                          const {
                            'label': "Select Customer Group*",
                            'value': "0"
                          },
                          ...context
                              .watch<CommonDataProvider>()
                              .selectCustomersGroupData
                        ],
                        taxNumberController: taxNumberController,
                        addressController: addressController,
                        cityController: cityController,
                        stateController: stateController,
                        postalCodeController: postalCodeController,
                        countryController: countryController,
                        onCustomerGroupChanged: (value) {
                          setState(() {
                            customerGroup = value;
                          });
                        },
                        message: message,
                      ),
                    ),
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
                  AppInput(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    icon: HeroIcons.shieldCheck,
                    password: true,
                    fancy: true,
                    errorLine: message?.errors?['confirmPassword'],
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding * 2,
                  ),
                  AppButton(
                    onPressed: () {
                      handleSubmit(context);
                    },
                    title: "Submit",
                  ),
                  const SizedBox(
                    height: AppSpacing.kDefaultPadding * 2,
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
                              dark: getThemeColor(context)
                                  ?.shade50
                                  .withValues(alpha: 0.6),
                              light: getThemeColor(context)
                                  ?.shade900
                                  .withValues(alpha: 0.6),
                            ),
                            fontFamily: getThemeFont(context),
                          ),
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Login Now",
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
                    height: AppSpacing.kDefaultPadding * 6,
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
