import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/payment_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            RadioListTile<int>(
              value: 0,
              groupValue: provider.paymentOption,
              activeColor: AppColors.greenColor,
              onChanged: (int? value) {
                provider.selectPayment = 0;
              },
              title: const Text('Online Payment (Credit/Debit)'),
              subtitle: const Text('Powered by Stripe'),
            ),
            Divider(color: AppColors.greenColor),
            RadioListTile<int>(
              value: 1,
              groupValue: provider.paymentOption,
              activeColor: AppColors.greenColor,
              onChanged: (int? value) {
                provider.selectPayment = 1;
              },
              title: const Text('Cash on Delivery'),
              subtitle: const Text('Pay when your order is delivered'),
            ),
            Divider(color: AppColors.greenColor),
          ],
        );
      },
    );
  }
}
