import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/models/address_model.dart';
import 'package:freshkart/view_model/services/user_services.dart';

class AddressProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> addresses = [];
  Map<String, dynamic>? selectedAddress;
  set selectAddress(address) => selectedAddress = address;
  addNewAddress(AddressModel address) {
    firestore
        .collection('users')
        // .doc(UserServices.uid)
        .doc(UserServices.currentUser!.uid)
        .collection('addresses')
        .doc()
        .set(address.toMap());
    getAllAddress();
  }

  updateAddress(AddressModel address, String docId) {
    firestore
        .collection('users')
        // .doc(UserServices.uid)
        .doc(UserServices.currentUser!.uid)
        .collection('addresses')
        .doc(docId)
        .update(address.toMap());
    getAllAddress();
  }

  getAllAddress() async {
    final snapshot =
        await firestore
            .collection('users')
            // .doc(UserServices.uid)
            .doc(UserServices.currentUser!.uid)
            .collection('addresses')
            .get();
    addresses =
        snapshot.docs.map((item) {
          var data = item.data();
          data['docId'] = item.id;
          return data;
        }).toList();
    notifyListeners();
  }

  deleteAddress(String docId) {
    firestore
        .collection('users')
        // .doc(UserServices.uid)
        .doc(UserServices.currentUser!.uid)
        .collection('addresses')
        .doc(docId)
        .delete();
    getAllAddress();
  }
}
