import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/screens/cart/checkout_page.dart';
import 'package:freshkart/view/widgets/tiles/toast_tile.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class PurchaseButtons extends StatelessWidget {
  final ProductModel product;
  const PurchaseButtons({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                context.read<CartProvider>().addToCart(
                  name: product.name,
                  price:
                      product.offer
                          ? num.parse(product.offerPrice)
                          : num.parse(product.price),
                );
                showToast('${product.name} Added to cart');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (c) => CheckoutPage(product: product, isBuyNow: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
