/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_customer
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

class EditCustomerScreen extends StatefulWidget {
  const EditCustomerScreen({super.key, required this.id});

  final int id;

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  Message? message;
  late Customer customer;
  bool bothCustomerAndSupplier = false;
  String? customerGroup = "0";
  late TextEditingController nameController;
  late TextEditingController imageController;
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

  void fetchData(BuildContext context, int index) {
    setState(() {
      customer = context.read<CommonDataProvider>().customers[index];
      nameController.text = customer.customerName;
      companyNameController.text = customer.companyName ?? "";
      taxNumberController.text = customer.taxNo ?? "";
      emailController.text = customer.email ?? "";
      phoneController.text = customer.phoneNumber ?? "";
      addressController.text = customer.address ?? "";
      cityController.text = customer.city ?? "";
      stateController.text = customer.state ?? "";
      postalCodeController.text = customer.postalCode ?? "";
      countryController.text = customer.country ?? "";
      customerGroup = customer.customerGroup != null
          ? customer.customerGroup?.id.toString()
          : "0";
      bothCustomerAndSupplier = customer.both ?? false;

      if (customer.user != null && !customer.user!) {
        addUser = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    imageController = TextEditingController();
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
    fetchData(context, widget.id);
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
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
    message = await CustomerAPI.update(
      customer.id,
      Customer(
        id: customer.id,
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
                .read<CommonDataProvider>()
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
      title: "Edit Customer",
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
        if (customer.user != null && !customer.user!)
          AppCheckBox(
            hintText: "Add User",
            value: addUser,
            onChanged: (value) {
              setState(() {
                addUser = value!;
              });
            },
            errorLine: message?.errors?['user'],
          ),
        if (customer.user != null && !customer.user!)
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
                    errorLine: message?.errors?['name'],
                  ),
                  AppInput(
                    hintText: "Password",
                    password: true,
                    controller: passwordController,
                    errorLine: message?.errors?['password'],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
