// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:taskcommerceapp/utilies/snakbar.dart';

class StripeService {
  static const String apiBase = "https://api.stripe.com/v1";
  static const String paymentApiUrl = '$apiBase/payment_intents';
  static const String stripeSecretKey =
      'sk_test_51Qj0rTKG4URMcep7fBJGyrQG4f9zmKRsx2JnMZOeT1B308CygaEr4TxtDSRZY1CIDjmSEkC8372HVeJMSPhWSOZr00t4WLCxLc';

  static final Map<String, String> headers = {
    "Authorization": "Bearer $stripeSecretKey",
    "Content-Type": "application/x-www-form-urlencoded",
  };

  // Initialize Stripe with a publishable key
  static void init(String publishableKey) {
    Stripe.publishableKey = publishableKey;
  }

  // Create a payment intent
  static Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      final body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await http.post(
        Uri.parse(paymentApiUrl),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }

  // Initialize the payment sheet
  static Future<void> initPaymentSheet({
    required String amount,
    required String currency,
    required String merchantDisplayName,
  }) async {
    try {
      // Create a payment intent
      final paymentIntent = await createPaymentIntent(amount, currency);

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: merchantDisplayName,
          style: ThemeMode.system,
        ),
      );
    } catch (e) {
      throw Exception('Error initializing payment sheet: $e');
    }
  }

  // Present the payment sheet
  static Future<void> presentPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      SnackbarUtils.showSnackbar(
        context,
        "Payment successful!",
        isSuccess: true,
      );
    } on StripeException catch (e) {
      SnackbarUtils.showSnackbar(
        context,
        "Payment cancelled or failed: ${e.error.localizedMessage}",
        isSuccess: false,
      );
    } catch (e) {
      SnackbarUtils.showSnackbar(
        context,
        "Error presenting payment sheet: $e",
        isSuccess: false,
      );
    }
  }

  // Calculate the amount in cents (Stripe requires amount in the smallest currency unit)
  static String _calculateAmount(String amount) {
    final intAmount = (double.parse(amount) * 100).toInt(); // Convert to cents
    return intAmount.toString();
  }
}
