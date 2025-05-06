import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/screens/products/listed_products.dart';
import 'package:freshkart/core/utils/colors.dart';

class HomeHorizondalProductsTitleRow extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  const HomeHorizondalProductsTitleRow({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (c) => SeeAllProductsPage(
                          products: products,
                          title: title,
                        ),
                  ),
                ),
            child: Text(
              'See all',
              style: TextStyle(
                color: AppColors.greenColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
