/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_biller
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/screens/people/biller/models/biller.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditBillerScreen extends StatefulWidget {
  const EditBillerScreen({super.key, required this.id});

  final int id;

  @override
  State<EditBillerScreen> createState() => _EditBillerScreenState();
}

class _EditBillerScreenState extends State<EditBillerScreen> {
  late Biller biller;
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

  void fetchData(BuildContext context, int index) {
    setState(() {
      biller = context.read<CommonDataProvider>().billers[index];
      nameController.text = biller.name;
      companyNameController.text = biller.companyName;
      vatNumberController.text = biller.vatNumber ?? "";
      emailController.text = biller.email;
      phoneController.text = biller.phoneNumber;
      addressController.text = biller.address;
      cityController.text = biller.city;
      stateController.text = biller.state ?? "";
      postalCodeController.text = biller.postalCode ?? "";
      countryController.text = biller.country ?? "";
    });
  }

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

    fetchData(context, widget.id);
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

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Biller",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
        ),
        AppFilePicker(
          allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif'],
          hintText: "Image",
          allowMultiple: false,
          controller: imageController,
        ),
        AppInput(
          hintText: "Company Name",
          controller: companyNameController,
        ),
        AppInput(
          hintText: "VAT Number",
          keyboardType: TextInputType.number,
          controller: vatNumberController,
        ),
        AppInput(
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
        ),
        AppInput(
          hintText: "Phone Number",
          keyboardType: TextInputType.phone,
          controller: phoneController,
        ),
        AppInput(
          hintText: "Address",
          controller: addressController,
        ),
        AppInput(
          hintText: "City",
          controller: cityController,
        ),
        AppInput(
          hintText: "State",
          controller: stateController,
        ),
        AppInput(
          hintText: "Postal Code",
          controller: postalCodeController,
        ),
        AppInput(
          hintText: "Country",
          controller: countryController,
        ),
      ],
    );
  }
}
