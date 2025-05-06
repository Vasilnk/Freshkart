import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/screens/products/single_product_page.dart';
import 'package:freshkart/view/widgets/cards/product_card.dart';

class SimilarProductSection extends StatelessWidget {
  final List<ProductModel> similarProducts;
  const SimilarProductSection({super.key, required this.similarProducts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: similarProducts.length,
          separatorBuilder: (context, ind) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final product = similarProducts[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) {
                      return const ProductPage();
                    },
                  ),
                );
              },
              child: SizedBox(width: 150, child: ProductCard(product: product)),
            );
          },
        ),
      ),
    );
  }
}
