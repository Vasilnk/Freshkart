import 'package:flutter/material.dart';
import 'package:freshkart/models/cart_item_model.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view/screens/products/single_product_page.dart';
import 'package:freshkart/view/widgets/cart_section/count_controller.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final ProductModel product;
  final CartItemModel item;
  const CartItemTile({super.key, required this.product, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 115,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Row(
                spacing: 25,
                children: [
                  InkWell(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.network(product.images.first),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => const ProductPage()),
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        ' ${product.quantity} ${product.unitType}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      CountController(item: item, product: product),
                    ],
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const Icon(Icons.close, color: Colors.grey),
                    onTap: () {
                      context.read<CartProvider>().removeCartItem(product.name);
                    },
                  ),
                  Text(
                    '₹${item.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
