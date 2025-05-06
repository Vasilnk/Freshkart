import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:provider/provider.dart';

class CheckoutPriceDetails extends StatelessWidget {
  final bool? isBuyNow;
  final ProductModel? product;

  const CheckoutPriceDetails({super.key, this.isBuyNow, this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, child) {
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price (${isBuyNow == true ? 1 : provider.cartItems.length} items)',
                  style: AppStyles.mediumTextStyle,
                ),
                Text(
                  '₹ ${isBuyNow == true
                      ? product!.offer
                          ? product?.offerPrice
                          : product!.price
                      : provider.total}',
                  style: AppStyles.mediumTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery', style: AppStyles.mediumTextStyle),
                Text('₹35', style: AppStyles.mediumTextStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Payable', style: AppStyles.mediumTextStyle),
                Text(
                  '₹ ${isBuyNow == true ? int.parse(product!.offer ? product!.offerPrice : product!.price) + 35 : provider.total + 35}',
                  style: AppStyles.mediumTextStyle,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
