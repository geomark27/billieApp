/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sms_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class SmsSettingsScreen extends StatefulWidget {
  const SmsSettingsScreen({super.key});

  @override
  State<SmsSettingsScreen> createState() => _SmsSettingsScreenState();
}

class _SmsSettingsScreenState extends State<SmsSettingsScreen> {
  String? gateway;
  List<Map<String, String>> gateways = [
    {"label": "revesms", "value": "revesms"},
    {"label": "bulksmsbd", "value": "bulksmsbd"},
    {"label": "Tonkra", "value": "tonkra"},
    {"label": "Twilio", "value": "twilio"},
    {"label": "Clickatell", "value": "clickatell"},
  ];
  late Map<String, Map<String, TextEditingController>> gatewayControllers;
  bool makeDefault = false;

  @override
  void initState() {
    super.initState();
    gatewayControllers = {
      "revesms": {
        "apiKeyController": TextEditingController(),
        "secretKeyController": TextEditingController(),
        "callerIdController": TextEditingController(),
      },
      "bulksmsbd": {
        "tokenController": TextEditingController(),
      },
      "tonkra": {
        "apiTokenController": TextEditingController(),
        'senderIdController': TextEditingController(),
      },
      "twilio": {
        "accountSidController": TextEditingController(),
        'authTokenController': TextEditingController(),
        'twilioNumberController': TextEditingController(),
      },
      "clickatell": {
        "apiKeyController": TextEditingController(),
      },
    };
  }

  @override
  void dispose() {
    gatewayControllers["revesms"]?['apiKeyController']?.dispose();
    gatewayControllers["revesms"]?['secretKeyController']?.dispose();
    gatewayControllers["revesms"]?['callerIdController']?.dispose();
    gatewayControllers["bulksmsbd"]?['tokenController']?.dispose();
    gatewayControllers["tonkra"]?['apiTokenController']?.dispose();
    gatewayControllers["tonkra"]?['senderIdController']?.dispose();
    gatewayControllers["twilio"]?['accountSidController']?.dispose();
    gatewayControllers["twilio"]?['authTokenController']?.dispose();
    gatewayControllers["twilio"]?['twilioNumberController']?.dispose();
    gatewayControllers["clickatell"]?['apiKeyController']?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "SMS Setting",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Gateway",
          items: gateways,
          onChange: (value) {
            setState(() {
              gateway = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        if (gateway == "revesms")
          Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "API Key",
                  controller: gatewayControllers['revesms']
                      ?['apiKeyController'],
                ),
                AppInput(
                  hintText: "Secret Key",
                  controller: gatewayControllers['revesms']
                      ?['secretKeyController'],
                ),
                AppInput(
                  hintText: "Caller ID",
                  controller: gatewayControllers['revesms']
                      ?['callerIdController'],
                ),
              ],
            ),
          ),
        if (gateway == "bulksmsbd")
          Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "Token",
                  controller: gatewayControllers['bulksmsbd']
                      ?['tokenController'],
                ),
              ],
            ),
          ),
        if (gateway == "tonkra")
          Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "API Token",
                  controller: gatewayControllers['tonkra']
                      ?['apiTokenController'],
                ),
                AppInput(
                  hintText: "Sender ID",
                  controller: gatewayControllers['tonkra']
                      ?['senderIdController'],
                ),
              ],
            ),
          ),
        if (gateway == "twilio")
          Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "Account SID",
                  controller: gatewayControllers['twilio']
                      ?['accountSidController'],
                ),
                AppInput(
                  hintText: "Auth Token",
                  controller: gatewayControllers['twilio']
                      ?['authTokenController'],
                ),
                AppInput(
                  hintText: "Twilio Number",
                  controller: gatewayControllers['twilio']
                      ?['twilioNumberController'],
                ),
              ],
            ),
          ),
        if (gateway == "clickatell")
          Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "API Key",
                  controller: gatewayControllers['clickatell']
                      ?['apiKeyController'],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
