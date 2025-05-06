import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cards/product_card.dart';

class SeeAllProductsPage extends StatelessWidget {
  final List<ProductModel> products;
  final String title;
  const SeeAllProductsPage({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductCard(product: product),
            );
          },
        ),
      ),
    );
  }
}
