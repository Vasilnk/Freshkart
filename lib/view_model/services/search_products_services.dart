import 'package:flutter/widgets.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:provider/provider.dart';

class SearchProductsServices {
  searchFilterProducts(String query, List<ProductModel> allProducts) {
    List<ProductModel> filtered =
        allProducts.where((product) {
          final name = product.name.toLowerCase();
          final categoryName = product.categoryName.toLowerCase();
          return name.contains(query.toLowerCase()) ||
              categoryName.contains(query.toLowerCase());
        }).toList();
    return filtered;
  }

  fetchDiscountProducts(BuildContext context) {
    return context
        .read<ProductProvider>()
        .allProducts
        .where((product) => product.offer)
        .toList();
  }
}
