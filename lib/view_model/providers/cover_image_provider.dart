import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoverImageProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> coverImages = [];

  Future<void> getImages() async {
    try {
      final snapshot =
          await firestore
              .collection('coverImages')
              .doc('J4j2Inec09JTydHf2wkO')
              .get();

      final data = snapshot.data();

      if (data != null && data.containsKey('images')) {
        coverImages = List<String>.from(data['images']);
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching cover images: $e");
    }
  }
}
