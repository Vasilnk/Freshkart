import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = false;
  late String categoryName;
  set setCategoryName(String name) => categoryName = name;

  getCategories() async {
    isLoading = true;
    final snapshots = await firestore.collection('categories').get();
    categories = snapshots.docs.map((category) => category.data()).toList();
    isLoading = false;
    notifyListeners();
  }
}
