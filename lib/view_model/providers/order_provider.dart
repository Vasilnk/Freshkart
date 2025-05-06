import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class OrderProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> orders = [];
  bool isExpanded = false;
  bool isOrderExpanded = false;
  set expand(bool val) {
    isExpanded = val;
    notifyListeners();
  }

  set orderExpand(bool val) {
    isOrderExpanded = val;
    notifyListeners();
  }

  Future<void> addOrder(map) async {
    final orderTime = DateTime.now();
    final deliveryTime = DateTime.now().add(const Duration(days: 1));
    final orderId = orderTime.millisecondsSinceEpoch.toString().substring(
      5,
      11,
    );
    await firestore.collection('orders').doc(orderId).set({
      'userId': UserServices.currentUser!.uid,
      'orderId': orderId,
      'items': map['items'].map((e) => e.toMap()).toList(),
      'totalPrice': map['price'],
      'address': map['address'],
      'orderTime': orderTime,
      'delveryTime': deliveryTime,
      'orderStatus': 'Pending',
      'paidStatus': map['paidStatus'],
    });
  }

  getAllOrders() async {
    final snapShot =
        await firestore
            .collection('orders')
            .where('userId', isEqualTo: UserServices.currentUser!.uid)
            .get();
    orders = snapShot.docs.map((item) => item.data()).toList();

    orders.sort(
      (a, b) => (b['orderTime'] as Timestamp).compareTo(a['orderTime']),
    );
    notifyListeners();
  }
}
