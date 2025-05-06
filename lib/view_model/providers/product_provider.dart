import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/services/products_services.dart';

class ProductProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ProductsServices productServices = ProductsServices();

  List<ProductModel> productsByCategory = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> offerProducts = [];
  bool isLoading = false;
  late ProductModel selectedProduct;
  set setSelectedProduct(ProductModel product) => selectedProduct = product;

  getProductsByCategory(categoryName) async {
    isLoading = true;
    productsByCategory = await productServices.getProductsByCategory(
      categoryName,
    );

    isLoading = false;
    notifyListeners();
  }

  getAllProducts() async {
    isLoading = true;

    allProducts = await productServices.getAllProducts();

    isLoading = false;
    notifyListeners();
  }

  getOfferProducts() async {
    isLoading = true;
    notifyListeners();
    offerProducts = await productServices.getOfferProducts();

    isLoading = false;
    notifyListeners();
  }
}
