import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cards/product_card.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  final String productType;
  const ProductsPage({super.key, required this.productType});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();
    provider.getProductsByCategory(productType);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppbar(title: productType),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Consumer<ProductProvider>(
            builder: (context, value, child) {
              final products = value.productsByCategory;
              if (value.isLoading) {
                return SizedBox(
                  height: height * 0.7,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenColor,
                    ),
                  ),
                );
              } else if (products.isNotEmpty) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
