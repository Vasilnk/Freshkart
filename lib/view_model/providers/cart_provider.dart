import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/models/cart_item_model.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class CartProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<CartItemModel> cartItems = [];
  num total = 0;
  bool loading = false;
  getCartItems() async {
    loading = true;
    notifyListeners();
    final snapshots =
        await firestore
            .collection('users')
            .doc(UserServices.currentUser!.uid)
            .collection('cart')
            .get();
    cartItems =
        snapshots.docs.map((doc) => CartItemModel.fromMap(doc.data())).toList();

    loading = false;
    totalPrice();
    notifyListeners();
  }

  addToCart({name, price}) {
    if (cartItems.any((item) => item.productId == name)) {
      return;
    }
    firestore
        .collection('users')
        .doc(UserServices.currentUser!.uid)
        .collection('cart')
        .doc(name)
        .set({'productId': name, 'quantity': 1, 'price': price});
    getCartItems();
    totalPrice();
    notifyListeners();
  }

  removeCartItem(name) {
    firestore
        .collection('users')
        .doc(UserServices.currentUser!.uid)
        .collection('cart')
        .doc(name)
        .delete();

    getCartItems();
    totalPrice();
    notifyListeners();
  }

  updateCartItem({name, increment, price}) {
    firestore
        .collection('users')
        .doc(UserServices.currentUser!.uid)
        .collection('cart')
        .doc(name)
        .update({
          'quantity':
              increment ? FieldValue.increment(1) : FieldValue.increment(-1),
          'price': price,
        });
    totalPrice();

    getCartItems();

    notifyListeners();
  }

  totalPrice() async {
    final snapshots =
        await firestore
            .collection('users')
            .doc(UserServices.currentUser!.uid)
            .collection('cart')
            .get();

    total = snapshots.docs
        .map((item) {
          final price = double.tryParse(item.data()['price'].toString()) ?? 0;
          return price;
        })
        .fold(0, (sum, price) => sum + price);

    notifyListeners();
  }

  Future<void> deleteCart() async {
    final snapshots =
        await firestore
            .collection('users')
            .doc(UserServices.currentUser!.uid)
            .collection('cart')
            .get();

    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }

    cartItems.clear();
    total = 0;
    notifyListeners();
  }
}
