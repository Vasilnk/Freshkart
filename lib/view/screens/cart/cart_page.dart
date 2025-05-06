import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cart_section/cart_item_tile.dart';
import 'package:freshkart/view/widgets/cart_section/empty_cart_widget.dart';
import 'package:freshkart/view/widgets/cart_section/total_price_details_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Cart'),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return value.cartItems.isNotEmpty
              ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = value.cartItems[index];
                          final product = context
                              .read<ProductProvider>()
                              .allProducts
                              .firstWhere(
                                (product) => product.name == item.productId,
                              );

                          return CartItemTile(product: product, item: item);
                        },
                      ),
                      const CartPriceDetailsWidget(),
                    ],
                  ),
                ),
              )
              : const EmptyCartWidget();
        },
      ),
    );
  }
}
