import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:provider/provider.dart';

class WishlistProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductModel> favoriteProducts = [];
  List<String> favoriteProductIds = [];
  bool loading = false;

  addFavorite(String product, String uid) {
    firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(product)
        .set({'isFavorite': true});
    favoriteProductIds.add(product);
    notifyListeners();
  }

  removeFavorite(String product, String uid, BuildContext context) {
    firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(product)
        .delete();
    favoriteProductIds.remove(product);
    getWishlistProducts(uid, context.read<ProductProvider>().allProducts);
    notifyListeners();
  }

  getWishlistProducts(String uid, List<ProductModel> allProducts) async {
    loading = true;
    notifyListeners();

    final favoriteSnapshot =
        await firestore
            .collection('users')
            .doc(uid)
            .collection('wishlist')
            .get();
    final productIds = favoriteSnapshot.docs.map((doc) => doc.id).toList();
    favoriteProductIds = productIds;
    favoriteProducts =
        allProducts
            .where((product) => productIds.contains(product.name))
            .toList();
    loading = false;
    notifyListeners();
  }
}
