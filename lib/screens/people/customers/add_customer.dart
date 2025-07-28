/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_customer
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/customers/api/customers.dart';
import 'package:salepro/screens/people/customers/customers_list.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  Message? message;
  bool bothCustomerAndSupplier = false;
  String? customerGroup = "0";
  late TextEditingController nameController;
  late TextEditingController companyNameController;
  late TextEditingController taxNumberController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;
  late TextEditingController countryController;
  bool addUser = false;
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    companyNameController = TextEditingController();
    taxNumberController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    postalCodeController = TextEditingController();
    countryController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    companyNameController.dispose();
    taxNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await CustomerAPI.create(
      Customer(
        id: 0,
        customerName: nameController.text,
        companyName: companyNameController.text,
        taxNo: taxNumberController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        postalCode: postalCodeController.text,
        country: countryController.text,
        customerGroup: customerGroup == "0"
            ? context.read<CommonDataProvider>().customerGroups[0]
            : context.read<CommonDataProvider>().customerGroups[context
                .watch<CommonDataProvider>()
                .selectCustomersGroupData
                .indexWhere(
                  (c) => c['value'].toString() == customerGroup.toString(),
                )],
        both: bothCustomerAndSupplier,
        user: addUser,
        name: userNameController.text,
        password: passwordController.text,
      ),
      context.read<CommonDataProvider>().token,
    );
    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message!.success) {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "success");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const CustomersListScreen(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Customer",
      onSubmit: handleSubmit,
      children: [
        AppCheckBox(
          hintText: "Both Customer and Supplier",
          value: bothCustomerAndSupplier,
          onChanged: (value) {
            setState(() {
              bothCustomerAndSupplier = value!;
            });
          },
        ),
        AppSelect(
          hintText: "Customer Group",
          value: customerGroup,
          items: [
            const {'label': "Select Customer Group*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectCustomersGroupData
          ],
          onChange: (value) {
            setState(() {
              customerGroup = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['customer_group_id'],
        ),
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['customer_name'],
        ),
        AppInput(
          hintText: "Company Name",
          controller: companyNameController,
          errorLine: message?.errors?['company_name'],
        ),
        AppInput(
          hintText: "Tax Number",
          keyboardType: TextInputType.number,
          controller: taxNumberController,
          errorLine: message?.errors?['tax_no'],
        ),
        AppInput(
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          errorLine: message?.errors?['email'],
        ),
        AppInput(
          hintText: "Phone Number",
          keyboardType: TextInputType.phone,
          controller: phoneController,
          errorLine: message?.errors?['phone_number'],
        ),
        AppInput(
          hintText: "Address",
          controller: addressController,
          errorLine: message?.errors?['address'],
        ),
        AppInput(
          hintText: "City",
          controller: cityController,
          errorLine: message?.errors?['city'],
        ),
        AppInput(
          hintText: "State",
          controller: stateController,
          errorLine: message?.errors?['state'],
        ),
        AppInput(
          hintText: "Postal Code",
          controller: postalCodeController,
          errorLine: message?.errors?['postal_code'],
        ),
        AppInput(
          hintText: "Country",
          controller: countryController,
          errorLine: message?.errors?['country'],
        ),
        AppCheckBox(
          hintText: "Add User",
          value: addUser,
          onChanged: (value) {
            setState(() {
              addUser = value!;
            });
          },
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(),
          crossFadeState:
              addUser ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(
            milliseconds: 500,
          ),
          secondChild: Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "Username",
                  controller: userNameController,
                ),
                AppInput(
                  hintText: "Password",
                  password: true,
                  controller: passwordController,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
