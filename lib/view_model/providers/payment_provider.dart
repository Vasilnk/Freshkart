import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/order_provider.dart';
import 'package:freshkart/view/screens/cart/success_order.dart';
import 'package:freshkart/core/utils/stripe.dart';
import 'package:freshkart/view/widgets/cart_section/failed_payment_display.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:web/web.dart' as web;

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
      final clientSecret = paymentIntent!['client_secret'];
      try {
        if (kIsWeb) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (c) => PaymentScreen(clientSecret: clientSecret, map: map),
            ),
          );
        } else {
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikey',
            ),
          );
        }
      } catch (e) {
        throw ('Exeption : $e');
      }

      loading = false;
      notifyListeners();
      // await displalyPaymentSheet(context, map, isBuyNow);
    } catch (e) {
      loading = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => const FailedPaymentDisplay(),
      );
      throw ('Exeptions is: $e');
    }
  }

  displalyPaymentSheet(
    BuildContext context,
    Map<String, dynamic> map,
    bool isBuyNow,
  ) async {
    try {
      if (kIsWeb) {
        return;
      }
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
            print('error is    $error');
            throw Exception(error);
          });
    } catch (e) {
      print('Exeption on display payment sheet ');
    }
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

class PlatformPaymentElement extends StatelessWidget {
  final String clientSecret;
  const PlatformPaymentElement(this.clientSecret, {super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentElement(
      autofocus: true,
      enablePostalCode: true,
      clientSecret: clientSecret,
      onCardChanged: (event) {},
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final String clientSecret;
  final Map<String, dynamic> map;
  const PaymentScreen({
    super.key,
    required this.clientSecret,
    required this.map,
  });

  String getReturnUrl() => web.window.location.href;

  Future<void> confirmPayment(BuildContext context) async {
    try {
      try {
        // await WebStripe.instance.confirmPaymentElement(
        //   ConfirmPaymentElementOptions(
        //     confirmParams: ConfirmPaymentParams(return_url: getReturnUrl()),
        //   ),
        // );
      } catch (e) {
        print('confirm error  $e');
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const SuccessOrder()),
      );

      context.read<OrderProvider>().addOrder(map);
      context.read<CartProvider>().deleteCart();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Your Payment")),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PaymentElement(
                  clientSecret: clientSecret,
                  autofocus: true,
                  enablePostalCode: true,
                  onCardChanged: (details) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await confirmPayment(context);
                  },
                  child: const Text("Pay Now"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
