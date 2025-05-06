import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/widgets/cards/product_card.dart';

class HorizondalHomeProductsView extends StatelessWidget {
  final List<ProductModel> products;
  final bool isOffer;
  const HorizondalHomeProductsView({
    super.key,
    required this.products,
    this.isOffer = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = 155;

        if (constraints.maxWidth > 600) {
          width = 160;
        }
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = products[index];
              return Row(
                children: [
                  SizedBox(width: width, child: ProductCard(product: product)),
                  const SizedBox(width: 15),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
