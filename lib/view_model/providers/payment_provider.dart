import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/order_provider.dart';
import 'package:freshkart/view/screens/cart/success_order.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/stripe.dart';
import 'package:freshkart/view/widgets/cart_section/failed_payment_display.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaymentProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? paymentIntent;

  int paymentOption = 0;
  bool loading = false;

  set selectPayment(val) {
    paymentOption = val;
    notifyListeners();
  }

  Future<void> makeOnlinePayment(
    num toatlPrice,
    context,
    Map<String, dynamic> map,
    bool isBuyNow,
  ) async {
    try {
      loading = true;
      notifyListeners();
      paymentIntent = await createPaymentIntent(toatlPrice, 'INR');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Ikey',
        ),
      );
      loading = false;
      notifyListeners();
      displalyPaymentSheet(context, map, isBuyNow);
    } catch (e) {
      loading = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => const FailedPaymentDisplay(),
      );
    }
  }

  displalyPaymentSheet(
    BuildContext context,
    Map<String, dynamic> map,
    bool isBuyNow,
  ) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => const SuccessOrder()),
            );
            paymentIntent = null;
            await context.read<OrderProvider>().addOrder(map);

            if (isBuyNow != true) {
              context.read<CartProvider>().deleteCart();
            }
          })
          .onError((error, stackTrace) {
            throw Exception(error);
          });
    } catch (e) {}
  }

  createPaymentIntent(num amount, String currency) async {
    try {
      int amountInPaise = (amount * 100).toInt();

      Map<String, dynamic> body = {
        'amount': amountInPaise.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void processingCashonDelivery(
    BuildContext context,
    Map<String, dynamic> map,
    isBuyNow,
  ) {
    showDialog(
      context: context,
      builder: (con) {
        return Center(
          child: CircularProgressIndicator(color: AppColors.greenColor),
        );
      },
    );

    try {
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.of(context).pop();

          Future.delayed(const Duration(milliseconds: 300), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => const SuccessOrder()),
            );
            context.read<OrderProvider>().addOrder(map);

            if (isBuyNow != true) {
              context.read<CartProvider>().deleteCart();
            }
          });
        }
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => const FailedPaymentDisplay(),
      );
    }
  }
}
