/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_details
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails(
      {super.key,
      required this.nameController,
      required this.customerGroup,
      required this.taxNumberController,
      required this.addressController,
      required this.cityController,
      required this.stateController,
      required this.postalCodeController,
      required this.countryController,
      required this.onCustomerGroupChanged,
      required this.customerGroups,
      this.message});

  final List<Map<String, dynamic>> customerGroups;
  final TextEditingController nameController;
  final String customerGroup;
  final Function(String? value) onCustomerGroupChanged;
  final TextEditingController taxNumberController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postalCodeController;
  final TextEditingController countryController;
  final Message? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.kDefaultPadding * 0.5,
      ),
      child: Column(
        children: generateInputGroups(
          [
            AppInput(
              fancy: true,
              hintText: "Name",
              controller: nameController,
              errorLine: message?.errors?['customer_name'],
            ),
            AppSelect(
              fancy: true,
              hintText: "Customer Group",
              value: customerGroup,
              items: customerGroups,
              onChange: onCustomerGroupChanged,
              enableFilter: false,
              enableSearch: false,
              errorLine: message?.errors?['customer_group_id'],
            ),
            AppInput(
              fancy: true,
              hintText: "Tax Number",
              keyboardType: TextInputType.number,
              controller: taxNumberController,
              errorLine: message?.errors?['tax_no'],
            ),
            AppInput(
              fancy: true,
              hintText: "Address",
              controller: addressController,
              errorLine: message?.errors?['address'],
            ),
            AppInput(
              fancy: true,
              hintText: "City",
              controller: cityController,
              errorLine: message?.errors?['city'],
            ),
            AppInput(
              fancy: true,
              hintText: "State",
              controller: stateController,
              errorLine: message?.errors?['state'],
            ),
            AppInput(
              fancy: true,
              hintText: "Postal Code",
              controller: postalCodeController,
              errorLine: message?.errors?['postal_code'],
            ),
            AppInput(
              fancy: true,
              hintText: "Country",
              controller: countryController,
              errorLine: message?.errors?['country'],
            ),
          ],
        ),
      ),
    );
  }
}
