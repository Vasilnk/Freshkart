import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view/screens/cart/cart_page.dart';
import 'package:provider/provider.dart';

class CartIconWithCount extends StatelessWidget {
  const CartIconWithCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 22,
      right: 18,
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => const CartPage()),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, value, child) {
              int itemCount = value.cartItems.length;
              return itemCount > 0
                  ? Positioned(
                    top: 0,
                    right: 3,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
