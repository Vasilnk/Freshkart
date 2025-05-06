import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart/models/product_model.dart';

class ProductsServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collectionName = 'products';

  getProductsByCategory(String categoryName) async {
    try {
      final snapshot =
          await firestore
              .collection(collectionName)
              .where('categoryId', isEqualTo: categoryName)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } on FirebaseException {
      rethrow;
    }
  }

  getAllProducts() async {
    try {
      final snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } on FirebaseException {
      rethrow;
    }
  }

  getOfferProducts() async {
    try {
      final snapshot =
          await firestore
              .collection(collectionName)
              .where('offer', isEqualTo: true)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } on FirebaseException {
      rethrow;
    }
  }
}
