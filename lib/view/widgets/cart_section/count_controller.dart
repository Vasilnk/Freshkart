import 'package:flutter/material.dart';
import 'package:freshkart/models/cart_item_model.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:provider/provider.dart';

class CountController extends StatelessWidget {
  final CartItemModel item;
  final ProductModel product;
  const CountController({super.key, required this.item, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CartProvider>();
    return Row(
      spacing: 15,
      children: [
        item.quantity < 2
            ? const SizedBox(width: 24)
            : InkWell(
              onTap: () async {
                if (item.quantity > 1) {
                  num price =
                      item.price -
                      int.parse(
                        product.offer ? product.offerPrice : product.price,
                      );
                  await provider.updateCartItem(
                    increment: false,
                    name: product.name,
                    price: price,
                  );
                }
              },
              child: const Icon(Icons.remove),
            ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 204, 201, 201),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            item.quantity.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: () async {
            num price =
                item.price +
                int.parse(product.offer ? product.offerPrice : product.price);

            await provider.updateCartItem(
              increment: true,
              name: product.name,
              price: price,
            );
          },
          child: Icon(Icons.add, color: AppColors.greenColor),
        ),
      ],
    );
  }
}
