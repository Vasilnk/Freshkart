import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view/screens/cart/checkout_page.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:provider/provider.dart';

class CartPriceDetailsWidget extends StatelessWidget {
  const CartPriceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Price Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price', style: AppStyles.mediumTextStyle),
                Text('₹${value.total}', style: AppStyles.mediumTextStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('items', style: AppStyles.mediumTextStyle),
                Text(
                  value.cartItems.length.toString(),
                  style: AppStyles.mediumTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery charge', style: AppStyles.mediumTextStyle),
                Text(
                  '₹35',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: AppStyles.mediumTextStyle),
                Text(
                  '₹${value.total + 35}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const CheckoutPage()),
                  );
                },
                style: AppStyles.bigButton,
                child: Text('Checkout', style: AppStyles.bigButtonTextStyle),
              ),
            ),
          ],
        );
      },
    );
  }
}
