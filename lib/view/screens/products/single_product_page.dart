import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/widgets/cards/images_card.dart';
import 'package:freshkart/view/widgets/product_detail_section.dart/product_details_section.dart';
import 'package:freshkart/view/widgets/product_detail_section.dart/purchase_buttons.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductModel product;
  @override
  void initState() {
    super.initState();
    product = context.read<ProductProvider>().selectedProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                SizedBox(
                  child: ImagesSection(
                    images: product.images,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                ProductDetailsSection(product: product),
              ],
            ),
          ),

          PurchaseButtons(product: product),
        ],
      ),
    );
  }
}
