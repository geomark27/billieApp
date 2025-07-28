/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: gateway_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/settings/payment_gateways/bkash_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/mollie_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/paypal_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/paystack_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/pesapal_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/razorpay_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/sslcommerz_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/stripe_settings.dart';
import 'package:salepro/screens/settings/payment_gateways/xendit_settings.dart';
import 'package:salepro/widgets/form_screen.dart';

class GatewaySettingsScreen extends StatelessWidget {
  const GatewaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Payment Gateways",
      onSubmit: () {},
      children: const [
        PaypalSettings(),
        StripeSettings(),
        RazorpaySettings(),
        PaystackSettings(),
        MollieSettings(),
        XenditSettings(),
        BkashSettings(),
        SSLCommerzSettings(),
        PesapalSettings(),
      ],
    );
  }
}
