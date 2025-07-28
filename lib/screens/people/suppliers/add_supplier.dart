/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_supplier
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/people/suppliers/api/suppliers.dart';
import 'package:salepro/screens/people/suppliers/models/supplier.dart';
import 'package:salepro/screens/people/suppliers/suppliers_list.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({super.key});

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  late TextEditingController nameController;
  late TextEditingController imageController;
  late TextEditingController companyNameController;
  late TextEditingController vatNumberController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;
  late TextEditingController countryController;
  bool bothCustomerAndSupplier = false;
  String? customerGroup = "0";
  String? path;
  Message? message;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    imageController = TextEditingController();
    companyNameController = TextEditingController();
    vatNumberController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    postalCodeController = TextEditingController();
    countryController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    companyNameController.dispose();
    vatNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    if (path != null) {
      message = await SuppliersAPI.create(
        Supplier(
          id: 0,
          name: nameController.text,
          companyName: companyNameController.text,
          vatNumber: vatNumberController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          address: addressController.text,
          city: cityController.text,
          state: stateController.text,
          postalCode: postalCodeController.text,
          country: countryController.text,
        ),
        context.read<CommonDataProvider>().token,
        fileData: {
          "key": "image",
          "path": path.toString(),
        },
      );
    } else {
      message = await SuppliersAPI.create(
        Supplier(
          id: 0,
          name: nameController.text,
          companyName: companyNameController.text,
          vatNumber: vatNumberController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          address: addressController.text,
          city: cityController.text,
          state: stateController.text,
          postalCode: postalCodeController.text,
          country: countryController.text,
        ),
        context.read<CommonDataProvider>().token,
      );
    }
    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message!.success) {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "success");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const SuppliersListScreen(),
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
      title: "Add Supplier",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppFilePicker(
          allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif'],
          hintText: "Image",
          allowMultiple: false,
          controller: imageController,
          errorLine: message?.errors?['image'],
          onChanged: (img) {
            setState(() {
              path = (img as File).path;
            });
          },
        ),
        AppInput(
          hintText: "Company Name",
          controller: companyNameController,
          errorLine: message?.errors?['company_name'],
        ),
        AppInput(
          hintText: "VAT Number",
          keyboardType: TextInputType.number,
          controller: vatNumberController,
          errorLine: message?.errors?['vat_number'],
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
          hintText: "Both Customer and Supplier",
          value: bothCustomerAndSupplier,
          onChanged: (value) {
            setState(() {
              bothCustomerAndSupplier = value!;
            });
          },
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(),
          crossFadeState: bothCustomerAndSupplier
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(
            milliseconds: 500,
          ),
          secondChild: Column(
            children: generateInputGroups(
              [
                AppSelect(
                  hintText: "Customer Group",
                  value: customerGroup,
                  items: [
                    const {'label': "Select Customer Group*", 'value': "0"},
                    ...context
                        .watch<CommonDataProvider>()
                        .selectCustomersGroupData
                  ],
                  onChange: (value) {
                    setState(() {
                      customerGroup = value;
                    });
                  },
                  enableFilter: false,
                  enableSearch: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
